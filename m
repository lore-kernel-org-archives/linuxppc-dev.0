Message-ID: <19981214104446.A3769@bleck.ksu.ksu.edu>
Date: Mon, 14 Dec 1998 10:44:46 -0600
From: Zach Metzinger <wizkid@ksu.edu>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Restructure of arch/ppc/kernel and include/asm-ppc
References: <m2zp8te2rh.fsf@wf-rch.cirr.com> <Pine.LNX.4.02.9812131538310.871-100000@cassiopeia.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.02.9812131538310.871-100000@cassiopeia.home>; from Geert Uytterhoeven on Sun, Dec 13, 1998 at 06:59:59PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Dec 13, 1998 at 06:59:59PM +0100, Geert Uytterhoeven wrote:

> For PPC, we would need different MILO images for the different machine types.
> The kernel can be ELF on all machine types, since we put an ELF loader in MILO.
> MILO doesn't need much fancy driver stuff, just SCSI/IDE, floppy, keyboard and
> a simple console (serial, VGA text, offb). And BootX can become some special
> variant of MILO :-)

This would be very nice. In fact, it would probably solve some
problems with the broken OF on several of the pmac machines such as
IDE and netbooting.

Anyone been hunting down the serial port problems with early g3s? Is the
macrocell in apple's chip a true clone of the 8530 ESCC?

--- Zach

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
