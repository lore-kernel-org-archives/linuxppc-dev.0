Return-Path: <felipe@cvf.fr>
Received: from mh2.cvf.fr (unknown [213.56.76.234])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9E5532BF18
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Jan 2005 20:24:00 +1100 (EST)
From: Philippe Guyot <pguyot@cvf.fr>
To: mikemartin@linux.ca, Mike Martin <sydneymartin@gmail.com>
Date: Tue, 4 Jan 2005 10:23:37 +0100
References: <20050101150055.GA15400@pegasos> <200501031530.54487.pguyot@cvf.fr>
	<855e88d0050103200337efc719@mail.gmail.com>
In-Reply-To: <855e88d0050103200337efc719@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200501041023.37580.pguyot@cvf.fr>
Cc: Ulrich Teichert <krypton@ulrich-teichert.org>, linuxppc-dev@ozlabs.org,
	debian-powerpc@lists.debian.org
Subject: Re: 43p-140 install issues
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 04 January 2005 05:03, Mike Martin wrote:
> (Re-posting with shorter attachment to please the list gods. Sorry)
>
> > If there is such a deadline, why not consider to install first a woody
> > (many successes exist) then upgrading to sarge after ?
>
> Ok... trying again with Leigh Brown's boot image and a woody root
> floppy and a woody CD.
>
> The console capture is below. Leigh's kernel boots up great, asks for
> a root floppy and then ...
>
> VFS: Insert root floppy and press ENTER
>
> FAT: bogus logical sector size 1981
> FAT: bogus logical sector size 1981
> read_super_block: can't find a reiserfs filesystem on (dev 02:00,
> block 64, size 1024)
> read_super_block: can't find a reiserfs filesystem on (dev 02:00,
> block 8, size 1024)
> Kernel panic: VFS: Unable to mount root fs on 02:00
>
> Reiserfs? Huh? I tried it twice, two different floppies. Both written
> as follows (as suggested in Debian manual):
> sudo dd if=root.bin of=/dev/fd0 bs=1024 conv=sync ; sync
> \1440+0 records in
> 1440+0 records out
> 1474560 bytes transferred in 120.042950 seconds (12284 bytes/sec)
>
> I can however boot the installation I made earlier using Leigh's
> image. I have completed the installation and it runs ... for a short
> period of time. After about 5 minutes or so it stops responding to the
> console and to pings.
>

 BTW, what about your firmware? Is it the most recent one ?


> MikeMartin
