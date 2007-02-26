Return-Path: <bounces@nabble.com>
Received: from talk.nabble.com (www.nabble.com [72.21.53.35])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E10EEDDEC6
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 26 Feb 2007 14:28:57 +1100 (EST)
Received: from [72.21.53.38] (helo=jubjub.nabble.com)
	by talk.nabble.com with esmtp (Exim 4.50) id 1HLWXn-00008K-9C
	for linuxppc-embedded@ozlabs.org; Sun, 25 Feb 2007 19:28:55 -0800
Message-ID: <9153024.post@talk.nabble.com>
Date: Sun, 25 Feb 2007 19:28:55 -0800 (PST)
From: Nethra <nethra_gmit@yahoo.co.in>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] jffs2 file system
In-Reply-To: <200702241830.29259.juergen.beisert@weihenstephan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <9097247.post@talk.nabble.com>
	<1172144688.2759.0.camel@vader.jdub.homelinux.org>
	<9132046.post@talk.nabble.com>
	<200702241830.29259.juergen.beisert@weihenstephan.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



 i m getting same error after disabling FTL. Yes partions are correct..here
is flinfo output

=> flinfo

Bank # 1: Sharp 28F016SC (16 Mbit, 32 x 64K)
  Size: 8 MB in 32 Sectors
  Sector Start Addresses:
    FF800000      FF840000      FF880000      FF8C0000      FF900000
    FF940000      FF980000      FF9C0000      FFA00000      FFA40000
    FFA80000      FFAC0000      FFB00000      FFB40000      FFB80000
    FFBC0000      FFC00000      FFC40000      FFC80000      FFCC0000
    FFD00000      FFD40000      FFD80000      FFDC0000      FFE00000
    FFE40000      FFE80000      FFEC0000      FFF00000 (RO) FFF40000 (RO)
    FFF80000      FFFC0000

nethra

[...]
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 50MHz system bus speed for PIO modes; override with
> idebus=xx
> elevator: using anticipatory as default io scheduler
> $Id: ftl.c,v 1.55 2005/01/17 13:47:21 hvr Exp $

Flash Translation Layer? JFFS2 does not need it (I believe).

> physmap flash device: 800000 at ff800000
> RedBoot partition parsing not available
> Using physmap partition definition
> Creating 4 MTD partitions on "phys_mapped_flash":
> 0x00000000-0x00600000 : "User FS"
> mtd: Giving out device 0 to User FS
> ftl_cs: FTL header not found.

Disable the FTL when you try to use the content as JFFS2!

> 0x00600000-0x00700000 : "uImage"
> mtd: Giving out device 1 to uImage
> ftl_cs: FTL header not found.
> 0x00700000-0x00740000 : "bootloader"
> mtd: Giving out device 2 to bootloader
> ftl_cs: FTL header not found.
> 0x00740000-0x00780000 : "bootloader env"
> mtd: Giving out device 3 to bootloader env
> ftl_cs: FTL header not found.

Are these partitions correct? I cannot see where the definitions comes from. 

Juergen
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded



-- 
View this message in context: http://www.nabble.com/jffs2-file-system-tf3271928.html#a9153024
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
