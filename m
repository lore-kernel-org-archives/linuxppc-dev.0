Message-ID: <3A1DBEA0.CC560FD@writeme.com>
Date: Fri, 24 Nov 2000 01:04:32 +0000
From: Hadess <hadess@writeme.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Keycodes and Apple Pro Keyboard
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I just wanted to use nifty Window Maker shortcuts to have sound lower
and upper in XMMS. It seems that the new input layer doesn't know about
these new keys. So here I post the keycodes the kernel didn't like.
It said "keyboard.c: can't emulate rawmode for keycode 161" and the
likes
Please, may the appropriate person add this to the kernel...

keycode 85: F13
keycode 89: F14
keycode 90: F15

keycode 114: lower sound (mapped as F16 ?)
keycode 115: upper sound (mapped as F17 ?)
keycode 113: cut sound (mapped as F18 ?)
keycode 161: eject media (mapped as F19 ?)

I'll try to send a patch tomorrow if you want.

Cheers

--
/Hadess
http://hadess.net

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
