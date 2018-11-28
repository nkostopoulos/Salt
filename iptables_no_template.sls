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

incoming SSH:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - match: state
    - connstate: NEW,ESTABLISHED
    - source: '192.168.56.101'
    - dport: 22
    - protocol: tcp
    - save: True

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

incoming saltstack messages 4505:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - match: state
    - connstate: ESTABLISHED
    - sport: 4505
    - protocol: tcp
    - save: True

incoming saltstack messages 4506:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - match: state
    - connstate: ESTABLISHED
    - sport: 4506
    - protocol: tcp
    - save: True

allow saltstack 4505:
  iptables.append:
    - table: filter
    - chain: OUTPUT
    - jump: ACCEPT
    - match: state
    - connstate: NEW,ESTABLISHED
    - dport: 4505
    - protocol: tcp
    - save: True

allow saltstack 4506:
  iptables.append:
    - table: filter
    - chain: OUTPUT
    - jump: ACCEPT
    - match: state
    - connstate: NEW,ESTABLISHED
    - dport: 4506
    - protocol: tcp
    - save: True

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
