Date: Tue, 15 Dec 1998 22:50:35 -0600 (CST)
From: Troy Benjegerdes <hozer@drgw.net>
To: Geert Uytterhoeven <geert@geert.cs.kuleuven.ac.be>
cc: Corey Minyard <minyard@acm.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Restructure of arch/ppc/kernel and include/asm-ppc
In-Reply-To: <Pine.LNX.4.02.9812131538310.871-100000@cassiopeia.home>
Message-ID: <Pine.LNX.4.04.9812152246120.30336-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 13 Dec 1998, Geert Uytterhoeven wrote:

> 
> On 12 Dec 1998, Corey Minyard wrote:
> > This is a patch relative to 2.1.131 that significantly restructures
> > the Linux PPC stuff.  It is the first step in making the code more
> > modular and separating the machine-specific from the
> > machine-independant stuff.  This currently works on my MVME2700
> > board.

Great! I started working on something like this, but got sidetracked for
awhile. I'll verify it works on an MTX board and make the RTC code work
correctly (it currently doesn't set Motorola PReP boards at all)

> For PPC, we would need different MILO images for the different machine types.
> The kernel can be ELF on all machine types, since we put an ELF loader in MILO.
> MILO doesn't need much fancy driver stuff, just SCSI/IDE, floppy, keyboard and
> a simple console (serial, VGA text, offb). And BootX can become some special
> variant of MILO :-)

Please please please someone do this? Then I can remove the ugly hack I
have in matroxfb to remap the PCI registers to something sane.

--------------------------------------------------------------------------
| Troy Benjegerdes    |    troybenj@iastate.edu    |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
