Date: Sun, 4 Jul 2004 17:06:43 -0400
From: David Eger <eger@havoc.gtf.org>
To: xorg@freedesktop.org, linuxppc-dev@lists.linuxppc.org
Subject: xkb and macintosh
Message-ID: <20040704210643.GA5697@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


My question for you all:
  Does anyone use the macintosh keymaps in X(.org|Free86)?

I have a Powerbook running a recent linux kernel (2.6.x series).
I tried to set my keyboard to the intuitively obvious settings:

    Option "XkbRules"  "xorg"
    Option "XkbModel"  "powerbook"
    Option "XkbLayout" "en_US"
    Option "XkbVariant" "nodeadkeys"
    Option "XkbOptions"        ""

And I got some strange results:
+ Pressing Alt+a key gives me accented characters
+ Trying to press Alt-x (for M-x in emacs) from an xterm sent M-8
   to emacs.
+ Standard Backspace vs Delete problem.

PPC/linux standardized on 'linux keycodes' that sorta look like
a PC keyboard with the extra keys, so when I set the settings
back to:

    Option "XkbRules"    "xorg"
    Option "XkbModel"    "pc104"
    Option "XkbLayout"   "us"
    Option "XkbVariant"  ""
    Option "XkbOptions"  ""

things work fine.  (Though I'm still trying to grok how I can make
my Open Apple key compose those nice accented characters...)

-dte

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
