#!/bin/bash
echo -e "Content-type: text/html\n"
echo " "
echo "<html><body>"
echo "<h1> PAQUETS DEBIAN </h1>"

sudo mkdir -p /var/www/html/archives # dossier qui contiendra les paquets .deb 
sudo cp -rf /var/cache/apt/archives /var/www/html/archives #mettre à jour le cache d'Apache au cas ou un nouveau paquet .deb a été deplacé

for i in $( ls /var/cache/apt/archives | grep -E '\.deb$' ) ; do
        echo "<p> $i <a href="/archives/$i" download>  Telecharger</a> </p>"

done

echo "</body></html>"

#après avoir  copié tous les paquets .deb de /var/cache/apt/archives dans le documentRoot (/var/www) d'apache (car sinon Apache ne pourra pas les tro>
#on a télécharger les paquets .deb


