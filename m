Message-Id: <199903100706.IAA00340@piglet.cpu.lu>
Date: Wed, 10 Mar 1999 08:06:16 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Promise Ultra33 in PowerMac?
To: linuxppc-dev@lists.linuxppc.org, hedrick@astro.dyer.vanderbilt.edu
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

I'm thinking about adding a Promise Ultra33 UDMA IDE controller to my
PowerMac. Those things, and especially the IDE disks, are so damned
cheap...

Anyway, does anybody have any idea whether such a beast would work with
the current ide driver stuff? I guess that PCI-wise, there should be no
problem. It's more a question of who initialises te board, as that may
be done by BIOS on-controller in an i386 machine, and has to be done by
the driver on a PowerPC box.

Using i386 boards in a PowerPC box under Linux can be done, as
demonstrated by my Compaq-OEM Matrox Millenium which works happily
(excpet a few quirks not related to its i386-ness).

Any thoughts (apart from 'drop that idea, buy SCSI' ;-) ?

Thanks

Michel

PS Andre, you got this mail because you're listed as maintainer of the
IDE stuff. If you know any other more apropriate oracle to answer this,
please forward...

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
