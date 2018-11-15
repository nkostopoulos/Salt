system:
  network.system:
    - enabled: True
    - hostname: lolololo.example.com
    - apply_hostname: True
    - gateway: 10.0.2.2
    - gatewaydev: enp0s3
    - nozerocond: True
    - nisdomain: example.com

enp0s8:
  network.managed:
    - enabled: True
    - type: eth
    - proto: none
    - ipaddr: 10.0.0.2
    - netmask: 255.255.255.0

enp0s9:
  network.managed:
    - enabled: True
    - type: eth
    - proto: dhcp
    - ipaddr: 192.168.56.102
    - netmask: 255.255.255.0

enp0s10:
  network.managed:
    - enabled: True
    - type: eth
    - proto: none
    - ipaddr: 10.0.5.1
    - netmask: 255.255.255.0
