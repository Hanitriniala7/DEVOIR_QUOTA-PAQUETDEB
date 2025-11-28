#!/bin/bash

#verification /home

verification_home() #partition /home
{

     
 	 for i in $(repquota /home | grep "+") ; do
 	 
          read user used soft hard grace
          soft=${soft//[^0-9]/}
          used=${used//[^0-9]/}
          hard=${hard//[^0-9]/}
          
          occupe=$((soft - used ))
          echo " 0 6 * * *  echo \"Vous avez dépassé $occupe de la limite imposée , vous avez $grace pour libérer cette espace \" | mail -s \"Alerte quota \" $user"  >> cron   
          
         done
          
}


#verification /data

verification_soft_data() 
{


   
    	for i in $(repquota /data | grep "+") ; do #pour les users
   
          read user used soft hard grace
          soft=${soft//[^0-9]/}
          used=${used//[^0-9]/}
          hard=${hard//[^0-9]/}
          
          occupe=$((soft -used))
          
          echo " 0 6 * * *  echo \"Vous avez dépassé $occupe de la limite imposée , vous avez $grace pour libérer cette espace \" | mail -s \"Alerte quota \" $user"  >> cron 
         done
   
         for i in $(repquota -g /data | grep "+") ; do #pour les groupes
   
          read group used soft hard grace
          soft=${soft//[^0-9]/}
          used=${used//[^0-9]/}
          hard=${hard//[^0-9]/}
          
           occupe=$((soft -used))
           echo "0 6 * * *   echo \"$group dépasse $occupe de la limite imposée \" | mail -s \"Alerte quota \" root " >> cron  #envoie le mail à root 
          done
}

verification_hard_data() 
{

     
 	 for i in $(repquota /data ) ; do
 	 
          read user used soft hard grace
          soft=${soft//[^0-9]/}
          used=${used//[^0-9]/}
          hard=${hard//[^0-9]/}
          
          difference=$((used - hard ))
          
              if [ "$difference" -lt 0 ] ; then
                
              echo " 0 6 * * *  echo \"Vous avez dépassé   la limite imposée \" | mail -s \"Alerte Quota  \" $user"  >> cron
              fi   
          
         done
         
         
          for i in $(repquota -g /data ) ; do
 	 
          read group used soft hard grace
          soft=${soft//[^0-9]/}
          used=${used//[^0-9]/}
          hard=${hard//[^0-9]/}
          
          difference=$((used - hard ))
          
              if [ "$difference" -lt 0 ] ; then #hard dépassé
                
              echo " 0 6 * * *  echo \"le groupe $groupe  dépasse  la limite imposée \" | mail -s \"Alerte Quota  \" root "  >> cron
              fi   
          
         done
          
}
crontab -l > cron #sauvegarder les autres cron 
verification_home
verification_soft_data
verification_hard_data
crontab  < cron # définition des cron pour les mails envoyés aux utilisateurs ou groupes (1fois/jour à 6:00)

