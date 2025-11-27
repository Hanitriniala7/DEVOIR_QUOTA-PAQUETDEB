#!/bin/bash

#verification /home

verification_home() #partition /home
{
 nombre_de_depassement=$(repquota /home | grep "+" | wc -l) #soft dépassé

  for i in $(repquota /home | grep "+") ; do
        
         read user used soft hard grace
         echo "Vous avez depassez la limite imposée ,vous occupé l'espace de tolérance de $soft vous avez $grace pour libérer cette espace " | mail -s "Alerte quota" $user

}


#verification data

verification_data() #partition /data
{

   nombre_de_depassement=$(repquota /data | grep "+" | wc -l) #soft dépassé
   
   for i in $(repquota /data | grep "+") ; do #pour les users
   
          read user used soft hard grace
          echo "Vous avez depassez la limite imposée ,vous occupé l'espace de tolérance de $soft vous avez $grace pour libérer cette espace " | mail -s "Alerte quota" $user
   
          
   nombre_de_depassement=$(repquota /data | grep "+" | wc -l) #soft dépassé
   
   for i in $(repquota -g /data | grep "+") ; do #pour les groupes
   
          read user used soft hard grace
          echo "Vous avez depassez la limite imposée ,vous occupé l'espace de tolérance de $soft vous avez $grace pour libérer cette espace " | mail -s "Alerte quota" $user
          
}

verification_data
verification_home



