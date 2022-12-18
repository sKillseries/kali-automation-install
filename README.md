# kali-vagrant

## Setup
First, install [packer](https://www.packer.io/), [VMware](https://www.vmware.com/products/workstation-player/workstation-player-evaluation.html), [VirtualBox](https://www.virtualbox.org/), and [qemu](https://www.qemu.org/download/).

On Kali Linux, this can be accomplished by running
```
apt install packer virtualbox virtuabox-ext-pack qemu
```

However, VMware will still need to be manually installed.

Then `cp kali-vars.json.template kali-vars.json` and fill in the values for `kali-var.json`.

**NOTE**: If on Windows, changing the line `"accelerator": "kvm",` in `config.json` to use an accelerator on our system is mandatory. We can check what accelerators we have with `qemu-system-x86_64 -accel ?`. Likely we will change the line to be `"accelerator": "tcg",`.

## Running the build

```
packer build -var-file=kali-vars.json config.json
```

This will upload to the Vagrant cloud.
To avoid doing that and keeping the build local, remove the `vagrant-cloud` post-processor from the config file.

## Running the build (headless)
To run headless builds, you will need to ensure you have the Extension Pack installed and then edit the config.json file to add
```
"headless": "1",
```
In the `"builders"` section before `"boot_command"`
