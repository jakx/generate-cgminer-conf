#!/usr/bin/env bash
#Jack Daines
#https://github.com/jakx
#A script to setup miners
#Thu May  1 15:31:49 PDT 2014

import subprocess
import json

#ATI_IN='\n* 0. 01:00.0 AMD Radeon R9 200 Series                           \n  1. 02:00.0 AMD Radeon HD 7900 Series \n  2. 03:00.0 AMD Radeon R9 200 Series                           \n  3. 07:00.0 AMD Radeon R9 290 Series\n  4. 08:00.0 AMD Radeon R9 290 Series\n* - Default adapter\n';

ATI_IN = subprocess.Popen(["aticonfig", "--list-adapters"], stdout=subprocess.PIPE).communicate()[0]
json_data=open('miner_conf.json')
miner_data = json.load(json_data)
#pprint(miner_data)

json_data.close()

#print miner_data["m7900"]["threadconcurrency"]


video_cards = []
for line in ATI_IN.splitlines():
    if line.find('HD 7900') > 0:
        video_cards.append(['m7900'])
    elif line.find('R9 290') > 0:
         video_cards.append(['m290'])
    elif line.find('R9 200') > 0:
         video_cards.append(['m270'])

#print(''.join(video_cards[len(video_cards) - 1]))
fileout_string = "\"thread-concurrency\": \""
for i, video_card in enumerate(video_cards):
#    print video_card
    fileout_string +=miner_data[''.join(video_card)]["threadconcurrency"]
    if i != len(video_cards) - 1:
        fileout_string +=","

fileout_string+="\"\n"


fileout_string += "\"intensity\": \""
for i, video_card in enumerate(video_cards):
    fileout_string +=miner_data[''.join(video_card)]["intensity"]
    if i != len(video_cards) - 1:
#    if video_card != video_cards[len(video_cards) - 1]:
        fileout_string +=","

fileout_string+="\"\n"

fileout_string += "\"gpu-engine\": \""
for i, video_card in enumerate(video_cards):
    fileout_string +=miner_data[''.join(video_card)]["gpuengine"]
    if i != len(video_cards) - 1:
#    if video_card != video_cards[len(video_cards) - 1]:
        fileout_string +=","

fileout_string+="\"\n"

fileout_string += "\"gpu-memclock\": \""
for i, video_card in enumerate(video_cards):
    fileout_string+=miner_data[''.join(video_card)]["gpumemclock"]
    if i != len(video_cards) - 1:
#   if video_card != video_cards[len(video_cards) - 1]:
        fileout_string+=","

fileout_string+="\"\n"


fileout_string += "\"worksize\": \""
for i, video_card in enumerate(video_cards):
    fileout_string+=miner_data[''.join(video_card)]["worksize"]
    if i != len(video_cards) - 1:
        fileout_string+=","

fileout_string+="\"\n"

fileout_string+="}"

print fileout_string
