# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.provider :virtualbox do |vb, override|
    vb.gui = true
    vb.customize ["modifyvm", :id, "--vram", "128"]
    vb.customize ["modifyvm", :id, "--graphicscontroller", "vmsvga"]
  end
  config.vm.provider :vmware_desktop do |vmware|
    vmware.gui = true
    vmware.vmx["ide0:0.clientdevice"] = "FALSE"
    vmware.vmx["ide0:0.devicetype"] = "cdrom-raw"
    vmware.vmx["ide0:0.filename"] = "auto detect"
  end
  config.vm.provider :libvirt do |libvirt|
    libvirt.disk_bus = "virtio"
    libvirt.driver = "kvm"
    libvirt.video_vram = 256
  end
end
