#run as root
import os
os.system("iwconfig")
while True:
	iface = input("\nWhich interface would you like to change?\n> ")
	mode = input("0. Monitor\n1. Managed\n> ")
	if mode == "0":

		os.system(f"ifconfig {iface} down")
		os.system("airmon-ng check kill")
		os.system(f"iwconfig {iface} mode monitor")
		os.system(f"ifconfig {iface} up")
		break

	elif mode == "1":
		os.system(f"ifconfig {iface} down")
		os.system("airmon-ng check kill")
		os.system(f"iwconfig {iface} mode managed")
		os.system(f"ifconfig {iface} up")
		os.system("service network-manager start")
		break

	else:
		print("Please choose a valid operator.")
		continue	