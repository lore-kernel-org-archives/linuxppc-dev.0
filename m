Message-Id: <200010221630.SAA01006@piglet.grunz.lu>
Date: Sun, 22 Oct 2000 18:30:01 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Keyboard trouble with XF 4.0.1
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

I finally found the time to upgrade to Franz Sirl's XF 4.0.1 rpms. I
hoped to solve some of my keyboard problems, but it got worse :-((

My setup:

- Apple Extended Keyboard II (dmesg shows handler 3:
ADB keyboard at 2, handler set to 3
Detected ADB keyboard, type ISO, swapping keys.)

- kernel 2.2.17pre20-ben3 (the source tarball from benh's site) (to get
the new input stuff, which is enabled)
- XF 4.0.1 rpms from Franz (XFree86-4.0.1-0.36a)
- XKB enabled (but I couldn't get a decent map loaded... went back to
  xmodmap)

First question: does anybody have pointers or info about how to setup
XKB? I've looked around a fair bit, but found nothing of value. Nothing
that specifies how to change the layout without blindly relying on some
undocumented options...

Second, my Alt'ed or Shift-Alt'ed keys still don't work. Under Linux
keycodes, there is no difference whether Alt is pressed or not; the
resulting key is the same, and xev shows the same old keycode as without
Alt.

Under ADB keycodes, there is a reaction to Alt, but it seems to be to
_turn_off_ the highest bit in the resulting keysym. The keycode is
right, though....

Then, with ADB keycodes, the key left of '1' and the one right to
'Shift_L' are swapped vs. my previous setup. Is it now 'the right way'?
Could be, since the default US map I got with X was right... So I guess
those keys have been swapped in the 'old' code for ages.

Anybody got any help? Especially the the Alt problem is _really_
annoying, since I have many usefull keys on an Alt'ed binding (like @,
#, \ and |).

Thanks

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
