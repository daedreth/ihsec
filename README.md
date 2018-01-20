# ihsec

I hate switching emacs configs.

Alright, this is it, it manages your configs, nothing else.

It may not be the most intelligent script you have ever stumbled upon but it is functional.

If it's stupid and it works it ain't stupid.


# How do I get this?

You kinda need to have bash installed.

  ~~~ sh
  $ git clone https://github.com/daedreth/ihsec.git
  $ cd ihsec
  $ sudo make
  ~~~

Now grab all your emacs.d and put them in `/home/<user>/.ihsec/`.
Give them unique names without whitespace and get to it.


# How do I use this?

  ~~~ sh
  $ ihsec list
  ~~~

This will give you a list of all your options. Pick the one you'd like to apply and:

  ~~~ sh
  $ ihsec set <your-choice>
  ~~~

To remove a config (yes, the entire directory):

  ~~~ sh
  $ ihsec del <your-choice>
  ~~~

If you are overwhelmed by the complexity of this software:

  ~~~ sh
  $ ihsec
  ~~~


# Credits
- rms
