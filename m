Date: Sat, 27 Feb 1999 12:39:57 -0500 (EST)
From: satadru pramanik <satadru@umich.edu>
To: Martin Costabel <costabel@wanadoo.fr>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.2.2 compilation errors
In-Reply-To: <36D7BD44.8904739@wanadoo.fr>
Message-ID: <Pine.LNX.4.10.9902271238280.1561-100000@beer.pub.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


2.2.2 from ftp.us.kernel.org
ac4 frm Alan Cox's ftp site.
using modified linux-pmac ftp site dot.config.
does this answer the where from?


On Sat, 27 Feb 1999, Martin Costabel wrote:

I wasn't able to get this kind of error with a stock Linus-2.2.2 kernel.
Could this be either the -ac4 extensions or the USB stuff that you have
enabled (where is this from, anyway?).

--
Martin

satadru pramanik wrote:
> 
> Thanks again for all of the useful suggestions.  Further along the
> compilation chain, i came across this fatal error with the pmac_ide stuff.
> Luckily, since I have a 7600, w/o ide, i could just disable this, but it
> would be nice to get this working in Linus' tree, since his tree is
> mirrored everywhere.
> -sat.
> ---compilation output---
> t/net.a drivers/scsi/scsi.a drivers/cdrom/cdrom.a drivers/sound/sound.a
> drivers/pci/pci.a drivers/macintosh/macintosh.a drivers/video/video.a \
>         /mnt/ibm/sin/src/kernel/linux/lib/lib.a \
>         --end-group \
>         -o vmlinux
> arch/ppc/kernel/kernel.o: In function `find_ide_boot':
> arch/ppc/kernel/kernel.o(.text.init+0x18e2): undefined reference to
> `pmac_ide_count'
[etc]


--=
satadru pramanik `satadru@umich.edu' www.umich.edu/~satadru
MIS, Student Publications
"I'm old enough to be living in the future I was warned about."
  - Myron Krueger
=--


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
