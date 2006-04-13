Return-Path: <lagrange@fr.oleane.com>
Received: from smtp10.clb.oleane.net (smtp10.clb.oleane.net [213.56.31.32])
	by ozlabs.org (Postfix) with ESMTP id C516C67DFB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Apr 2006 00:50:46 +1000 (EST)
From: "Laurent Lagrange" <lagrange@fr.oleane.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: RE: NAND and JFFS2 supports in Linux 2.4
Date: Thu, 13 Apr 2006 16:49:35 +0200
Message-ID: <006201c65f09$7d809140$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1144790375.3659.3.camel@yoda.jdub.homelinux.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hello

> -----Message d'origine-----
> De : Josh Boyer

> > Linux 2.4.18 or 2.4.25 do not support this device,
> Those are entire too old.
Except for some customers which must maintain kernels during many years :-)

> > Linux 2.4.31 seems supporting this device but JFFS2 is not adapted,
> NAND + JFFS2 + 2.4 is not a supported combination.
That's the problem i am facing with.

> > Linux 2.4.32 does not support this device anymore.
> Odd.  Do you have a diff from .31 to .32?
Not a diff but

1) in Linux 2.4.32, I have the following files :
Config.in        diskonchip.c  nand_bbt.c        rtc_from4.c  tx4925ndfmc.c
Makefile         edb7312.c     nand_ecc.c        s3c2410.c    tx4938ndfmc.c
Makefile.common  h1910.c       nand_ids.c        sharpsl.c*
au1550nd.c       nand.c        nandsim.c         spia.c
autcpu12.c       nand_base.c   ppchameleonevb.c  toto.c
$Id: nand_ids.c,v 1.12 2005/02/16 09:33:27 gleixner Exp $

2) in Linux 2.4.32, I just have the following files :
autcpu12.c  edb7312.c  nand.c      nand_ids.c
Config.in   Makefile   nand_ecc.c  spia.c
with a very old nand_ids.c.
$Id: nand_ids.c,v 1.1 2002/12/02 22:06:04 gleixner Exp $

> > On www.linux-mtd.infradead.org, it seems that Linux 2.4 is no more
supported.
> Well, 2.4 is supported but no new features go in that tree.  Including
> NAND support in JFFS2.  If there is a bug in the 2.4 code that is
> present in MTD/JFFS2 it can certainly still be fixed.
OK

> > Any help would be welcome
> You might try your luck with patching the latest 2.4 kernel with MTD
> CVS.  But be warned that quite a few things have changed, so
> you'd have to essentially backport.
> And keep in mind that it's not supported.
Yes, I saw  that many things have changed and are not be easily backported.
I checked the MTD CVS. All that I found are in the Linux kernel 2.4.31 or
2.6.x.

> -----Message d'origine-----
> De : Jaap-Jan Boor
> Take a look at the 2.4 http://www.denx.de kernel, it has NAND
> and jffs2 support.
Thanks but, I retreived the same files than in the other kernels.


Thanks again for your ideas
I will see what I can do

Bye
Laurent
