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

- Pull this directory under ~/dotenv
- Copy `.bashrc` into your home directory.
- Put any proprietary files under ~/dotenv/private


Status
------

Just started working on this, so it's very incomplete. Things to do:

- How do other dotfiles fit into this? probably want symlinking
- How about the loveable emacs env?
- Separate out the loading environment from the actual dotfiles.
