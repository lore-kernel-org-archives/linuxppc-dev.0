Message-ID: <3AAF73C0.D0DA94A6@inn.ericsson.se>
Date: Wed, 14 Mar 2001 14:36:00 +0100
From: Kenneth Johansson <kenneth.johansson@inn.ericsson.se>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: walnut 405
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have finally got my walnut card from IBM and compiled linux for it.
I used the version from Frank (mvista) on area51 dated 01_03_03 but changed
the configuration to remove kgdb and enable float emulation.

Things looks quite good I now have a debian potato for ppc running on the card
but there is a few problems.

1. It kills the Ethernet port on a cisco catalyst 5505 switch/router.
   This is something I never seen before but when I use a port that is 10Mb
linux sends out something that the switch dose not like and it simply
disable the port. I put a 3com 10Mb hub between but the same problem so it's
not electric. I was however unsuccessful in getting any useful information
from the network people on what rule was violated. It dose not happen on a
100Mb port. I guess that it is some clock or timing that is wrong in the
Ethernet driver.

2. it's not possible to run gdb


3. dpkg segfaults
   It's quite easy to get into a state where dpkg segfaults. A reboot fixes
the problem. To get into the mess again all you have to do is start emacs.


On the bright side alot of stuff works. I did the kernel compile test and that
worked.

If anybody want's to run debian I could write a small howto but I'am not going
to do that if nobody ask's for it.


--
Kenneth Johansson
Ericsson Business Innovation AB   Tel: +46 8 404 71 83
Viderögatan 3                     Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@inn.ericsson.se

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
