#!/usr/bin/env bash
#Jack Daines
#https://github.com/jakx
#A script to setup miners
#Thu May  1 15:31:49 PDT 2014

import subprocess
import json


ATI_IN = subprocess.Popen(["aticonfig", "--list-adapters"], stdout=subprocess.PIPE).communicate()[0]
json_data=open('miner_conf.json')
miner_data = json.load(json_data)

json_data.close()



video_cards = []
for line in ATI_IN.splitlines():
    if line.find('HD 7900') > 0:
        video_cards.append(['m7900'])
    elif line.find('R9 290') > 0:
         video_cards.append(['m290'])
    elif line.find('R9 200') > 0:
         video_cards.append(['m270'])

fileout_string = "\"thread-concurrency\": \""
for i, video_card in enumerate(video_cards):
    fileout_string +=miner_data[''.join(video_card)]["threadconcurrency"]
    if i != len(video_cards) - 1:
        fileout_string +=","

fileout_string+="\"\n"


fileout_string += "\"intensity\": \""
for i, video_card in enumerate(video_cards):
    fileout_string +=miner_data[''.join(video_card)]["intensity"]
    if i != len(video_cards) - 1:
        fileout_string +=","

fileout_string+="\"\n"

fileout_string += "\"gpu-engine\": \""
for i, video_card in enumerate(video_cards):
    fileout_string +=miner_data[''.join(video_card)]["gpuengine"]
    if i != len(video_cards) - 1:
        fileout_string +=","

fileout_string+="\"\n"

fileout_string += "\"gpu-memclock\": \""
for i, video_card in enumerate(video_cards):
    fileout_string+=miner_data[''.join(video_card)]["gpumemclock"]
    if i != len(video_cards) - 1:
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
