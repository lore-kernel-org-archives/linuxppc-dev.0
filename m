Message-Id: <200010300050.e9U0oej23495@shell.faradic.net>
Date: Sun, 29 Oct 2000 19:50:36 -0500
From: jingai <jingai@floatingpenguins.com>
To: "linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>
Subject: USB keyboard & 2.2.18pre17
Reply-To: jingai@floatingpenguins.com
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello list, got a bit of a problem.  I just rsync'ed both Paul's and Ben's
stable tree, 2.2.18pre17, and with both my USB keyboard no longer
works.  With verbose debugging output enabled, I see that the
keyboard, mouse, and printer are all detected, but for some reason
the keyboard is not attached as a keyboard device.  I have a feeling
it may have something to do with the new ADB keyboard/mouse
drivers, because I also have an ADB keyboard and mouse connected,
both of which work.  However, my USB mouse and printer function
properly, so I'm thinking the new input layer stuff is seeing the ADB
keyboard first and it doesn't attempt to attach the USB keyboard
because it's already found one (ie, bug).

I'll try to have a look over the code and find the bug myself, but I
was just wondering if anyone else has noticed this, and if there is
already a patch available..

BTW, the keyboard works fine with 2.2.17 and 2.4.0-test10, although
with 2.2.17 it would sporadically lose my keyboard entirely, but it
doesn't happen *too* often.

Also, the keyboard is a Macally iKey (the blue one to match the
blue G3s..)

Regards,
Jonathan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
