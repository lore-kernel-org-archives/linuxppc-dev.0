Content-Type: text/plain;
  charset="us-ascii"
From: Trevor Woerner <ppc339@vtnet.ca>
Reply-To: ppc339@vtnet.ca
To: linuxppc-dev@lists.linuxppc.org
Subject: can't write
Date: Wed, 28 May 2003 23:19:27 -0400
MIME-Version: 1.0
Message-Id: <200305282319.27041.ppc339@vtnet.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Now that I can get to the point where I can configure and mount my
compact flash card I find yet another interesting twist... I can't
write to the device.

If I mount it read-only everything is fine. I can read the device, do a
directory listing, copy thing from it, execute binaries, open files...
all that nice stuff. But the instant I try to write, things go up in
smoke.

I wrote my own test modules to try to isolate this issue so I can study
it more. My module gives the same results the kernel gets: no matter
what is written to the device (ATA command 0x30), the entire sector
always ends up being entirely filled with zeros.

Whether I write "0xbeef" 256 times or copy one sector (say sector 0) to
some other place. When I read the newly written sector back, all it
contains are zeros.

Anyone seen something like this before?

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
