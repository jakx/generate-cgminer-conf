#!/usr/bin/env bash
#Jack Daines
#https://github.com/jakx
#A script to setup miners
#Thu May  1 15:31:49 PDT 2014

#$ATI_IN=`aticonfig --list-adapters`;

ATI_IN='* 0. 01:00.0 AMD Radeon HD 7900 Series 
  1. 02:00.0 AMD Radeon R9 200 Series                           
  2. 07:00.0 AMD Radeon R9 290 Series

* - Default adapter';

#get_video_card(){
#        OWNER=$(stat -c %u /mnt/nfs 2>&1)
#        if  echo $OWNER | grep -q "Transport endpoint is not connected" ; then
#            sudo umount /mnt/nfs
#            sshfs jakx@jakx.webfactional.com:/home/jakx/ /mnt/nfs/
#        fi

#        if [ "$OWNER" != 791 ]; then
#            sshfs jakx@jakx.webfactional.com:/home/jakx/ /mnt/nfs/
#        fi
#}


VIDEO_CARDS=()
OLD_IFS=$IFS;
IFS=$'\n'; 
for line in $ATI_IN; do 
    VIDEO_CARD='';
    if echo $line | grep -q 'HD 7900'; then
        VIDEO_CARD='m7900';
    elif echo $line | grep -q 'R9 290'; then
        VIDEO_CARD='m290';
    elif echo $line | grep -q 'R9 200'; then
        VIDEO_CARD='m270';
    fi
    if [ "$VIDEO_CARD" != '' ]; then
        VIDEO_CARDS=("${VIDEO_CARDS[@]}" "$VIDEO_CARD");
    fi
 done
#echo ${VIDEO_CARDS[@]};
IFS=$OLD_IFS; 


#echo "" > cgminer.conf;
#output=$(cat cgminer.start);
#echo $output, > cgminer.conf;
cat cgminer.start > cgminer.conf;

echo -ne "    ">> cgminer.conf

echo -ne "\"thread-concurrency\":" >> cgminer.conf;
for VIDEO_CARD in "${VIDEO_CARDS[@]}"
do
  echo -ne `cat ./miner_conf.json | jq ".$VIDEO_CARD | .threadconcurrency"`>> cgminer.conf
  if [ "$VIDEO_CARD" != ${VIDEO_CARDS[${#VIDEO_CARDS[@]} - 1]} ]; then
      echo -ne ",">> cgminer.conf
  fi
done
echo  "," >> cgminer.conf;

echo -ne "    ">> cgminer.conf
echo -ne "\"intensity\":" >> cgminer.conf;
for VIDEO_CARD in "${VIDEO_CARDS[@]}"
do
  echo -ne `cat ./miner_conf.json | jq ".$VIDEO_CARD | .intensity"`>> cgminer.conf
  if [ "$VIDEO_CARD" != ${VIDEO_CARDS[${#VIDEO_CARDS[@]} - 1]} ]; then
      echo -ne "," >> cgminer.conf
  fi
done
echo "," >> cgminer.conf;

echo -ne "    ">> cgminer.conf
echo -ne "\"gpu-engine\":" >> cgminer.conf;
for VIDEO_CARD in "${VIDEO_CARDS[@]}"
do
  echo -ne `cat ./miner_conf.json | jq ".$VIDEO_CARD | .gpuengine"`>> cgminer.conf
  if [ "$VIDEO_CARD" != ${VIDEO_CARDS[${#VIDEO_CARDS[@]} - 1]} ]; then
      echo -ne ",">> cgminer.conf
  fi
done
echo ",">> cgminer.conf 

echo -ne "    ">> cgminer.conf
echo -ne "\"gpu-memclock\":" >> cgminer.conf;
for VIDEO_CARD in "${VIDEO_CARDS[@]}"
do
  echo -ne `cat ./miner_conf.json | jq ".$VIDEO_CARD | .gpumemclock"`>> cgminer.conf
  if [ "$VIDEO_CARD" != ${VIDEO_CARDS[${#VIDEO_CARDS[@]} - 1]} ]; then
      echo -ne ",">> cgminer.conf
  fi
done
echo "" >> cgminer.conf
echo "}" >> cgminer.conf
#echo -ne "," #> cgminer.conf;


#i=0;
#for VIDEO in "${VIDEO_CARDS[@]}" do
#  `cat ./miner_conf.json | jq "'.$VIDEO_CARD | .threadconcurrency'"`
#    hi=$(cat ./miner_conf.json);
#    echo "${VIDEO}";
#do
#done 
