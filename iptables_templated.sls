default policy for INPUT chain:
  iptables.set_policy:
    - chain: INPUT
    - policy: DROP
    - save: True

default policy for FORWARD chain:
  iptables.set_policy:
    - chain: FORWARD
    - policy: DROP
    - save: True

default policy for OUTPUT chain:
  iptables.set_policy:
    - chain: OUTPUT
    - policy: DROP
    - save: True

{% for ssh_user in pillar['allow_ssh_from'] %}
incoming SSH for {{ ssh_user }}:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - in-interface: {{ pillar['ssh_interface'] }}
    - match: state
    - connstate: NEW,ESTABLISHED
    - source: {{ ssh_user }}
    - dport: 22
    - protocol: tcp
    - save: True
{% endfor %}

outgoing SSH:
  iptables.append:
    - table: filter
    - chain: OUTPUT
    - jump: ACCEPT
    - match: state
    - connstate: ESTABLISHED
    - sport: 22
    - protocol: tcp
    - save: True

saltstack control messages 1:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - in-interface: {{ pillar['salt_interface'] }}
    - match: state
    - connstate: ESTABLISHED
    - sport: 4505
    - protocol: tcp
    - save: True

saltstack data messages 1:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - in-interface: {{ pillar['salt_interface'] }}
    - match: state
    - connstate: ESTABLISHED
    - sport: 4506
    - protocol: tcp
    - save: True

saltstack control messages 2:
  iptables.append:
    - table: filter
    - chain: OUTPUT
    - jump: ACCEPT
    - out-interface: {{ pillar['salt_interface'] }}
    - match: state
    - connstate: NEW,ESTABLISHED
    - destination: {{ pillar['saltstack_master'] }}
    - dport: 4505
    - protocol: tcp
    - save: True

saltstack data messages 2:
  iptables.append:
    - table: filter
    - chain: OUTPUT
    - jump: ACCEPT
    - out-interface: {{ pillar['salt_interface'] }}
    - match: state
    - connstate: NEW,ESTABLISHED
    - destination: {{ pillar['saltstack_master'] }}
    - dport: 4506
    - protocol: tcp
    - save: True

{% if pillar['allow_icmp'] == 'yes' %}
allow incoming icmp:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - match: state
    - connstate: NEW
    - proto: icmp
    - save: True

allow outgoing icmp:
  iptables.append:
    - table: filter
    - chain: OUTPUT
    - jump: ACCEPT
    - match: state
    - connstate: ESTABLISHED
    - proto: icmp
    - save: True
{% endif %}

give outgoing icmp to the machine:
  iptables.append:
    - table: filter
    - chain: OUTPUT
    - jump: ACCEPT
    - match: state
    - connstate: NEW
    - proto: icmp
    - save: True

give incoming icmp to the machine:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - match: state
    - connstate: ESTABLISHED
    - proto: icmp
    - save: True

{% for rule in pillar['rules_from_internet'] %}
from internet INPUT rule definition for {{ rule[1] }}:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: {{ rule[0] }}
    - match: state
    - connstate: NEW
    - dport: {{ rule[1] }}
    - protocol: {{ rule[2] }}
    - save: True

from internet OUTPUT rule definition for {{ rule[1] }}:
  iptables.append:
    - table: filter
    - chain: OUTPUT
    - jump: {{ rule[0] }}
    - match: state
    - connstate: NEW,ESTABLISHED
    - sport: {{ rule[1] }}
    - protocol: {{ rule[2] }}
    - save: True
{% endfor %}

{% for rule in pillar['rules_from_host'] %}
from host rule INPUT definition for {{ rule[1] }}:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: {{ rule[0] }}
    - match: state
    - connstate: ESTABLISHED
    - sport: {{ rule[1] }}
    - protocol: {{ rule[2] }}
    - save: True

from host rule OUTPUT definition for {{ rule[1] }}:
  iptables.append:
    - table: filter
    - chain: OUTPUT
    - jump: {{ rule[0] }}
    - match: state
    - connstate: NEW
    - dport: {{ rule[1] }}
    - protocol: {{ rule[2] }}
    - save: True
{% endfor %}

drop rule for INPUT chain:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: DROP
    - save: True

drop rule for FORWARD chain:
  iptables.append:
    - table: filter
    - chain: FORWARD
    - jump: DROP
    - save: True

drop rule for OUTPUT chain:
  iptables.append:
    - table: filter
    - chain: OUTPUT
    - jump: DROP
    - save: True
