system:
  network.system:
    - enabled: True
    - hostname: {{ pillar['system_hostname'] }}
    - apply_hostname: True
    - gateway: {{ pillar['default_gateway'] }}
    - gatewaydev: {{ pillar['gateway_interface'] }}
    - nozerocond: True
    - nisdomain: {{ pillar['minion_domain'] }}

{% for interface in pillar['interfaces'] %}
{{ interface[0] }}:
  network.managed:
    - enabled: True
    - type: eth
    - proto: {{ interface[1] }}
    - ipaddr: {{ interface[2] }}
    - netmask: {{ interface[3] }}
{% endfor %}
