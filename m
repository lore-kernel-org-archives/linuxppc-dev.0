Message-Id: <200007071603.RAA18464@hyperion.valhalla.net>
Date: Fri, 07 Jul 2000 17:03:06 +0100
Subject: 2.2.17pre10-ben1 & dmasound & atfb driver
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
CC: bh40@calva.net
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

well the good news.. is that the dmasound patch (referred to earlier)
applies cleanly and runs ok on 2.2.17pre10-ben1.

The bad news is that the fb doesn't work on my G3/beige (mach64) - starts
and then the screen 'slips sideways' by half and the whole thing stops dead
(no regs dump output).  I haven't got a serial term at present so no xmon
:-(

reverting to offb got it all up - although I need to reconfigure the mouse
stuff as well.

any ideas what I might be doing wrong?

Also, someone posted some instructions on how to set up the new input layer
but I can't seem to find them in my linuxppc archive  - I'm assuming that
the new stack has been back-ported to 2.2.17pre10 which is why my adbmouse
doesn't...

G3/beige
2.2.17pre10-ben1 ati support complied in.
BootX 1.2.2

TIA,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
