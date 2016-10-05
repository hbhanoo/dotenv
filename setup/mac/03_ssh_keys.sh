#!/bin/bash
if [ ! -f ~/.ssh/id_rsa ]; then
		read -p "Enter an email:" email
		echo follow the prompts...
		ssh-keygen -t rsa -b 4096 -C "$email"
fi
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

