Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B18F7DDEAB
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 Apr 2007 01:33:29 +1000 (EST)
Subject: Re: Powerpc newbie help
From: Jon Loeliger <jdl@freescale.com>
To: Gary Schumacher <gschumac@brocade.com>
In-Reply-To: <E1FC5EDA57236147B397280C5E6C130032FDBA@MC4EXCH04.mcdata.com>
References: <E1FC5EDA57236147B397280C5E6C130032FDBA@MC4EXCH04.mcdata.com>
Content-Type: text/plain
Message-Id: <1175873601.20336.35.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Fri, 06 Apr 2007 10:33:21 -0500
Cc: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 2007-04-06 at 08:33, Gary Schumacher wrote:
>  
> 
> I am in the process of upgrading a Linux kernel from 2.4,20 to 2.6.20 on
> a proprietary board that uses the PPC 750Fx (without Open Firmware) and
> am having the following problems:

I'm afraid I can't speak to the 750.

> 1.  Is there more information on Device Trees so I can construct one
> myself?

Use emacs. :-)

>   I have been reading "Device trees everywhere" and
> "booting-without-of".  Also, there are a number of *.dts files in
> /arch/powerpc/boot/dts that I have been looking at but more
> examples/HowTo information would be helpful.

This is really about the extent of the documentation that
is available without going to the official Open Firmware
spec as well.  I recommend a large Cabernet Franc if you
go that route. :-)  It is a known deficiency and it is being
worked on, just not fast enough for some.  Please feel free
to post proposals or questions to the linuxppc-dev list too!

> 2.  I have downloaded dtc-2006419.tar and was wondering if there is a
> newer version or do I need patches for this and if so where would I
> look?

Please use git to obtain a current repository from jdl.com:

    http://www.jdl.com/git_repos

    git clone git://www.jdl.com/software/dtc.git

There is a newer tar file (dtc-20070216.tgz) in www.jdl.com/software
if you are unable to git clone the repo directly.

> 3.  Where do I find glr_parser which is required to build dtc?

Please update your flex and bison in particular.  If you do
not have a glr parser, your version is, like, years old now.

HTH,
jdl
