Date: Wed, 6 Sep 2000 21:32:48 +0200
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: newer xfree86 4.0.1 patches
Message-ID: <20000906213248.A3749@suse.de>
Reply-To: linuxppc-dev@lists.linuxppc.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

you can find a newer ajoshi patch against xf4.0.1 at www.penguinppc.org/~olaf/

It contains a driver for Matrox cards, the B50 works fine now. Ken Aaker
from IBM did the work.

There is also a keycode file for ps/2 based machines like PReP and CHRP,
called "powerpcps2". It is a workaround, the arrow keys and the page
up/down block are dead as example. I guess it is a kernel bug.

Please let me know if the international maps work for you. I created
some maps in symbols/macintosh/*.

The (xf4) keyboard section might look like that:

Section "InputDevice"
  Driver        "keyboard"
  Identifier    "Keyboard[0]"
  Option        "Protocol"      "Standard"
  Option        "XkbLayout"     "de"
#  Option        "XkbVariant"    "nodeadkeys"
  Option        "XkbModel"      "macintosh"
  Option        "XkbRules"      "xfree86"
EndSection

Replace the "macintosh" with "powerpcps2" when you have a ps/2 keyboard.
Be sure to disable the Xmodmap stuff in ~/.Xmodmap and
/usr/X11R6/lib/X11/Xmodmap.


Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
