rules_from_internet: [['ACCEPT','53','udp'],['ACCEPT','123','udp']]
rules_from_host: [['ACCEPT','53','udp']]
allow_ssh_from: ['192.168.56.101','192.168.56.102','192.168.56.103']
ssh_interface: 'enp0s9'
salt_interface: 'enp0s8'
saltstack_master: '10.0.0.1'
allow_icmp: 'yes'
