import subprocess
import json


def save_output(command):
        proc = subprocess.Popen(command,stdout=subprocess.PIPE,shell=True)
        (out,err) = proc.communicate()
	return out

def get_minion_interfaces():
	command = "salt '*' network.interfaces --output json"
	minions_info_json = json.loads(save_output(command))
	output_information = dict()
	for minion in minions_info_json.keys():
		minion_name = str(minion)
		minion_json = minions_info_json[minion]
		minion_interfaces = list()
		for interface in minion_json.keys():
			minion_interfaces.append(str(interface))
		output_information[minion_name] = minion_interfaces
	
	print(output_information)



if __name__ == "__main__":
	get_minion_interfaces()
