In-Reply-To: <Pine.LNX.4.02.9812131538310.871-100000@cassiopeia.home>
Date: Mon, 14 Dec 1998 10:54:18 +0100
To: linuxppc-dev@lists.linuxppc.org,
        Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Restructure of arch/ppc/kernel and include/asm-ppc
Message-Id: <19981214105418.022383@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Dec 13, 1998, Geert Uytterhoeven <geert@geert.cs.kuleuven.ac.be>
wrote:

>For PPC, we would need different MILO images for the different machine types.
>The kernel can be ELF on all machine types, since we put an ELF loader in
>MILO.
>MILO doesn't need much fancy driver stuff, just SCSI/IDE, floppy,
keyboard and
>a simple console (serial, VGA text, offb). And BootX can become some special
>variant of MILO :-)

This could be a good idea since it would fix a big outstanding issue: The
inability of MacOS VM to lock contiguously enough space for the kernel
and ramdisk in lots of cases (the -622 error most people with virtual
memory ON are experiencing). If the booter was itself a nini-kernel that
takes care of further loading of the real kernel and ramdisk, this issue
would probably disappear.

Another thing that Paul and I are trying to define and implement: A way
to completely boot from a disk image on the HFS volume (and eventually
use this image as the read/write root volume). This would allow
installations of Linux on top of macos without reformatting &
repartitioning the hard disk.




-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
