Return-Path: <felipe@cvf.fr>
Received: from mh2.cvf.fr (mh2.cvf.fr [213.56.76.234])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 652272BDB5
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Jan 2005 21:56:19 +1100 (EST)
From: Philippe Guyot <pguyot@cvf.fr>
To: Sven Luther <sven.luther@wanadoo.fr>
Date: Mon, 3 Jan 2005 11:56:07 +0100
References: <20050101150055.GA15400@pegasos> <200501031056.30775.pguyot@cvf.fr>
	<20050103104848.GA14682@pegasos>
In-Reply-To: <20050103104848.GA14682@pegasos>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200501031156.07353.pguyot@cvf.fr>
Cc: Ulrich Teichert <krypton@ulrich-teichert.org>,
	Mike Martin <sydneymartin@gmail.com>, linuxppc-dev@ozlabs.org,
	debian-powerpc@lists.debian.org, mikemartin@linux.ca
Subject: Re: 43p-140 install issues
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 03 January 2005 11:48, Sven Luther wrote:
> On Mon, Jan 03, 2005 at 10:56:30AM +0100, Philippe Guyot wrote:
> > On Monday 03 January 2005 05:15, Mike Martin wrote:
> > > Now I'm very confused .... on my next reboot ... the network wouldn't
> > > work. After much trial and error, I got the current unstable d-i image
> > > to work. It did it all right up to the reboot (where is warns you that
> > > it doesn't have a boot loader installed).
> > >
> > > Now what!
> > >
> > > I have an installed system, but I can't figure out how to boot it! I
> > > have /boot/vmlinux on /dev/sdb1 and a root on /dev/sdb1. How do I
> > > write a boot sector or tell OpenFirmware to boot from this file? I
> > > tried to netboot and set root=/dev/sdb1 - but without the scsi modules
> > > loaded it fails to read the drives and panics.
> > >
> > > I think I neet to create a type 41 PReP boot partition and get the
> > > kernel onto it. I've found this thread:
> > > http://lists.gnu.org/archive/html/bug-parted/2002-09/msg00016.html
> > >
> > > and this:
> > > http://www.yellowdoglinux.com/support/solutions/champion_server/rs6k.sh
> > >tml
> > >
> > > I tried booting up with the installer, going to a shell after the scsi
> > > was active and the installed system was mounted. I used sfdisk from
> > > /target/sbin to create a 10 Meg type 41 partition on the first HD
> > > (/dev/sdb0 eventually). I used dd to copy /target/boot/vmlinux to this
> > > partition. But it still won't boot.
> >
> > I succeeded last year to install a woody on a 143P-140 whith the help of
> > Leigh Brown (thanks to him again). And two 150 whit sarge also.
> >
> > I'm not sure, but I have the feeling that your image on the prep
> > partition (should be type 0x41) is not able to determine where the root
> > is, so Leigh did a piece of code named "preptools" in order to patch the
> > image with the location of root.
>
> Hey, cool, where is this tool ? We need to package it for debian if it is
> not already, and use it in d-i, and maybe even mkvmlinuz directly.
>

Just over there....

http://www.solinno.co.uk/7043-140/downloads.php
But ask Leigh for details.


Friendly.
Felipe
