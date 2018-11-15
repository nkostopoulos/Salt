deny new dns:
  iptables.delete:
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - match: state
    - connstate: ESTABLISHED
    - dport: 53
    - protocol: udp
    - sport: 1025:65535
    - save: True

deny icmp:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: DROP
    - match: state
    - connstate: NEW
    - proto: icmp
    - save: True
