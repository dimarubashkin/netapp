$name="CDOT95"
$memory=6192
$IDE00="D:\NetApp\Simulator\vsim-esx-DOT9.5-cm-disk1.vmdk"
$IDE01="D:\NetApp\Simulator\vsim-esx-DOT9.5-cm-disk2.vmdk"
$IDE10="D:\NetApp\Simulator\vsim-esx-DOT9.5-cm-disk3.vmdk"
$IDE11="D:\NetApp\Simulator\vsim-esx-DOT9.5-cm-disk4.vmdk"

VBoxManage.exe createvm -name $NAME -ostype "FreeBSD_64" --register --basefolder D:\CDOT98
VBoxManage.exe modifyvm $name --ioapic on
VBoxManage.exe modifyvm $name --vram 16
VBoxManage.exe modifyvm $name --cpus 2
VBoxManage.exe modifyvm $name --memory $memory

VBoxManage.exe modifyvm $name --nic1 intnet --nictype1 82545EM --cableconnected1 on
VBoxManage.exe modifyvm $name --nic2 intnet --nictype2 82545EM --cableconnected2 on
VBoxManage.exe modifyvm $name --nic3 intnet --nictype3 82545EM --cableconnected3 on
VBoxManage.exe modifyvm $name --nic4 intnet --nictype4 82545EM --cableconnected4 on

VBoxManage.exe modifyvm $name --uart1 0x3F8 4
VBoxManage.exe modifyvm $name --uart2 0x2F8 3

VBoxManage.exe storagectl $name --name floppy --add floppy --controller I82078 --portcount 1 
VBoxManage.exe storageattach $name --storagectl floppy --device 0 --medium emptydrive

VBoxManage.exe storagectl $name --name IDE    --add ide    --controller PIIX4  --portcount 2

VBoxManage.exe storageattach $name --storagectl IDE --port 0 --device 0 --type hdd --medium $IDE00
VBoxManage.exe storageattach $name --storagectl IDE --port 0 --device 1 --type hdd --medium $IDE01
VBoxManage.exe storageattach $name --storagectl IDE --port 1 --device 0 --type hdd --medium $IDE10
VBoxManage.exe storageattach $name --storagectl IDE --port 1 --device 1 --type hdd --medium $IDE11

VBoxManage.exe export $name -o D:\NetApp\exported_sim95-vbox.ova

VBoxManage.exe unregistervm $name --delete