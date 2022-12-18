# kali-automation-install

L'outil kali-automation-install est un projet qui a pour vocation d'aider les pentester à créer de façon automatique des VM Kali Linux avec tous les outils nécessaires à la réalisation de la mission confiés.
C'est une vitrine de mes compétences acquises dans le monde opérationnel en tant qu'Administrateur/Ingénieur Système Réseaux et Sécurité avec des compétences dite DevOps pour le monde offensive cyber dans lequel
je m'oriente.

Cette outil permet de configurer Kali en Français et d'instancier le lancement d'un script bash qui installe les outils nécessaires.

Cet idée de projet m'est venu à l'esprit lors de ma formation ESD (Mastère Spécialisé Expert en Sécurité Digitale Bac+5) après le module Lead Pentester.

## Prérequis
Pour que le script soit utilisable, il faut au préalable installer [packer](https://www.packer.io/) ainsi que [VMware](https://www.vmware.com/products/workstation-player/workstation-player-evaluation.html) ou [VirtualBox](https://www.virtualbox.org/) en fonction de votre hyperviseur cible.

Sur Linux, il suffit de taper la commande suivante
```
apt install packer vagrant virtualbox virtuabox-ext-pack
```
Cependant, si vous souhaiter utilisé VMware, il faudra l'installer manuellement.
Exemple d'installation de VMware Player: https://lecrabeinfo.net/installer-vmware-workstation-player-sur-ubuntu-linux.html

**NOTE**: Concernant VMware, Packer fonctionne avec VMware Fusion (Mac OS), VMware Workstation (Linux et Windows), et VMware Player (uniquement Linux).

## Configuration

Une fois que l'hyperviseur de votre choix est installé, veuillez compléter les variables qui sont dans le fichier `kali-var.json`:
```
{
    "iso_url": "<Lien de Téléchargement Kali-Linux>",
    "iso_checksum": "<SHA256Checksum de l'ISO>
}
```

## Lancement du build

Pour VirtualBox:
```
packer build -var-file=kali-vars.json config-virtualbox.json
```

Pour VMware:
```
packer build -var-file=kali-vars.json config-vmware.json
```

## Lancement du build (headless)

Pour lancer le build en mode headless (sans aucune fenêtre), vous devrez vous assurer que le pack d'extension est installé (dans le cas de VirtualBox), puis modifier le fichier `config-<hyperviseur>` pour ajouter:
```
"headless": "1",
```
Dans la section `"builders"` avant `"boot_command"`

**INFOS**: Pour des raisons d'automatisation aucune interaction humaine n'est requise. A certaines étapes le timer avant que le script ne poursuivent les actions nécessaires peuvent prendre un certain temps, c'est normal. Par conséquent, si vous n'êtes pas en mode headless, veuillez faire aucune action manuel.
Dans certains cas, en fonction de la qualité et rapidité de votre réseaux ou de votre ordinateur, il faudra modifié les timers symbolisé par la variable `"<waitXX>"` situé dans la section `"builders"` dans `"boot_command"` situé dans le fichier `config-<hyperviseur>.json`.

**Attention**: Lors de la phase de lancement des scripts bash, les lignes deviendront rouge, ne vous inquiéter pas, il y a aucune erreur, c'est la coloration utilisé par packer lors de cette étape.

## Lancer la VM

```
vagrant up
```

Identifiant: vagrant
Password: vagrant

**Note**: Quand on exécute un `vagrant up`, Vagrant va copier la box dans un cache et elle ne sera pas détruite automatiquement.
Pour pallier à ce problème vous pourrez supprimer le dossier `output-<hypeviseur>-iso` et taper la commande `vagrant box remove <nom_de_la_box>`.
Il se peut que vous rencontriez le même problème avec VirtualBox si une VM porte le même nom, pour régler cela taper la commande `VBoxManage unregistervm <nom_de_la_vm> --delete`.