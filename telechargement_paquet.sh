#!/bin/bash
echo -e "Content-type: text/html\n"
echo " "
echo "<html><body>"
echo "<h1> DEBIAN </h1>"

for i in $( ls /var/cache/apt/archives | grep -E '\.deb$' ) ; do
        echo "<p> $i <a href="/archives/$i" download>  Telecharger</a> </p>"

done

echo "</body></html>"

#après avoir  copié tous les paquets .deb de /var/cache/apt/archives dans le documentRoot (/var/www) d'apache (car sinon Apache ne pourra pas les tro>
#on a télécharger les paquets .deb


