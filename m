Date: Sat, 19 Jun 1999 12:42:34 -0400 (EDT)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: linuxppc-dev@lists.linuxppc.org
cc: Sean Harding <sharding@gutenberg.uoregon.edu>,
        Geert.Uytterhoeven@cs.kuleuven.ac.be
Subject: platinumfb problem (cont. from long ago)
Message-ID: <Pine.LNX.3.96L.990619121249.2028A-100000@unix47.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Update on slightly broken platinumfb:
(see http://lists.linuxppc.org/listarcs/linuxppc-dev/199903/msg00120.html for
the end of the old thread)

The kernel installed with R5 still has the screwy palette. Kernel.org's 2.2.9
does too, as well as 2.2.7-vger (found in the /kernels directory on
linuxppc.org). The kernel used *during* the R5 installer had no
palette problems because it used offb (that had me confused for a minute).

Since the problem occurs in console as well as X (I'm going to assume the
LinuxPPC gdm backgroud is *not* brilliant magenta), Sean's patch seems pretty
necessary. The XF86 that comes with R5 has the same problem that Xpmac in R4
did, so I think the patch won't break anything XF86-specific, which Sean was
worried about.

Btw, if you're going to include something like xeyes in an installer, why not
make it xpat2 or a Tetris clone or something?

-Hollis


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
