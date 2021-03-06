fix_host_kvm ()
{
    echo "Making sure KVM (intel or amd) is loaded."
    if grep Intel /proc/cpuinfo &> /dev/null
    then
        KVM="kvm-intel"
    else
        KVM="kvm-amd"
    fi

    if ! grep $KVM /etc/modprobe.d/dist.conf &> /dev/null
    then
        echo "options $KVM nested=y" >> /etc/modprobe.d/dist.conf
    fi

    lsmod | grep $KVM &> /dev/null
    if [ $? -ne 0 ]
    then
        modprobe $KVM
    fi
}
