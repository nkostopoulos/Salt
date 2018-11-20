import subprocess
import json


def save_output(command):
        proc = subprocess.Popen(command,stdout=subprocess.PIPE,shell=True)
        (out,err) = proc.communicate()
	return out


if __name__ == "__main__":
	get_interfaces_command = "salt '*' network.interfaces --output json"
	minions_info_json = json.loads(save_output(get_interfaces_command))
	for minion in minions_info_json.keys():
		print("Configuring Minion: ",str(minion))
		
		hostname = raw_input("Give hostname for your minion: ")
		print(hostname)

		


		minion_json = minions_info_json[minion]
		minion_interfaces = set()
		for interface in minion_json.keys():
			minion_interfaces.add(str(interface))
		print("Minion: " + hostname + " interfaces: " + str(minion_interfaces))
