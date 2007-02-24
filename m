Return-Path: <juergen.beisert@weihenstephan.org>
Received: from bill.weihenstephan.org (bill.weihenstephan.org [82.135.35.21])
	by ozlabs.org (Postfix) with ESMTP id 905B8DDEBF
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 25 Feb 2007 04:30:35 +1100 (EST)
From: Juergen Beisert <juergen.beisert@weihenstephan.org>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] jffs2 file system
Date: Sat, 24 Feb 2007 18:30:27 +0100
References: <9097247.post@talk.nabble.com>
	<1172144688.2759.0.camel@vader.jdub.homelinux.org>
	<9132046.post@talk.nabble.com>
In-Reply-To: <9132046.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702241830.29259.juergen.beisert@weihenstephan.org>
Cc: Nethra <nethra_gmit@yahoo.co.in>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Saturday 24 February 2007 09:38, Nethra wrote:
[...]
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
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
