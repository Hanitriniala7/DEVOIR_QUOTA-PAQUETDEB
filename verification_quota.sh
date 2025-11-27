#!/bin/bash

#verification /home si soft dépassé

verification_home() #partition /home
{
 nombre_de_depassement=$(repquota /home | grep "+" | wc -l) #soft dépassé

 if [ "$nombre_de_depassement" -eq 0 ] ; then
      exit
 fi     

  for i in $(repquota /home | grep "+") ; do
        
         read user used soft hard grace 
         echo "Vous avez depassez la limite imposée ,vous occupé l'espace de tolérance de $soft vous avez $grace pour libérer cette espace " | mail -s "Alerte quota" $user

}


#verification /data si soft dépassé

verification_data() #partition /data
{

   nombre_de_depassement=$(repquota /data | grep "+" | wc -l) #soft dépassé
   
     if [ "$nombre_de_depassement" -eq 0 ] ; then
            exit
      fi     
   
   for i in $(repquota /data | grep "+") ; do #pour les users
   
          read user used soft hard grace
          echo "Vous avez depassez la limite imposée ,vous occupé l'espace de tolérance de $soft vous avez $grace pour libérer cette espace " | mail -s "Alerte quota" $user
   
          
   nombre_de_depassement=$(repquota -g /data | grep "+" | wc -l) #soft dépassé

      if [ "$nombre_de_depassement" -eq 0 ] ; then
            exit
      fi     
      
   for i in $(repquota -g /data | grep "+") ; do #pour les groupes
   
          read user used soft hard grace
          echo "Vous avez depassez la limite imposée ,vous occupé l'espace de tolérance de $soft vous avez $grace pour libérer cette espace " | mail -s "Alerte quota" $user
          
}

verification_data
verification_home

#Ce script est lancé 1 fois par semaine pour voir le si l'utilisateur/groupe ne dépassent pas le quota qui leur est attribué
#si soft atteint envoie de mail à l'utilisateur 

