dotenv
======

This project is not as fancy as many of the others (http://dotfiles.github.io) that manage your dotfiles.

I set out to solve a problem that I've run into while working at big (amazon, google) and small companies; 
there's a lot of confidential and proprietary stuff in my environment, but there's also a lot of small tweaks
that I make along the way.

I wanted a way to separate out my common env/setup from whatever specific setup I need for the given company/team.

What it does
------------

- Start up with a minimal/clean environment
- "Bootup" by typing 'sp' to start
- Files under ~/dotenv/common will be sourced first (in order), 
- followed by files in ~/dotenv/private


Getting Started
---------------

Pretty simple:

    git clone https://github.com/hbhanoo/dotenv.git
		cd dotenv
		./install.sh
		
- Put any proprietary files under ~/dotenv/private


Status
------

Right now this also contains all my personal dotfiles. Ideally the bootstrapping would be separate from my actual dotfiles.
