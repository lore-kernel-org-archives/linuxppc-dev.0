Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE009.bigfish.com (va3ehsobe006.messaging.microsoft.com
 [216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id A1BCBB6F65
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2011 14:55:38 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Jia Hongtao-B38951 <B38951@freescale.com>
Subject: Re: [linuxppc-release] [powerpc] boot up problem
Date: Fri, 2 Dec 2011 03:55:31 +0000
Message-ID: <4ED84C32.3010807@freescale.com>
References: <1320040492-6407-1-git-send-email-B38951@freescale.com>
 <1320040492-6407-2-git-send-email-B38951@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5DFD4DB8@039-SN1MPN1-005.039d.mgd.msft.net>
 <3E825AD9-1CD5-4D6D-8161-E6B4F1D32457@kernel.crashing.org>
 <3F607A5180246847A760FD34122A1E052DBCD1@039-SN1MPN1-003.039d.mgd.msft.net>
 <412C8208B4A0464FA894C5F0C278CD5DFD6BAB@039-SN1MPN1-005.039d.mgd.msft.net>
 <3EC6F9E0-C847-4DA8-AD8C-313976982A10@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5DFDC478@039-SN1MPN1-005.039d.mgd.msft.net>
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5DFDC478@039-SN1MPN1-005.039d.mgd.msft.net>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: Fleming Andy-AFLEMING <afleming@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jia Hongtao-B38951 wrote:
> Hi
>
> I just found that the 'next' branch you mentioned have problem to boot up=
.
> I test it in p1022ds and p1010rdb boards and the result are both the same=
.
> Note that for p1022ds I use "make p1022ds.dtb" to make the dtb file(36bit=
) with 36bit-uboot.
> And for p1010rdb I use all 32bit image.
> The problem list below:
>
> scsi0 : sata_fsl
> ata1: SATA max UDMA/133 irq 74
> fsl-sata fffe19000.sata: Sata FSL Platform/CSB Driver init
> scsi1 : sata_fsl
> ata2: SATA max UDMA/133 irq 41
> Fixed MDIO Bus: probed
> Unable to handle kernel paging request for data at address 0x00000000
> Faulting instruction address: 0xc0451630
> Oops: Kernel access of bad area, sig: 11 [#1]

Andy has phy driver patch that fixes this.

--=20
Timur Tabi
Linux kernel developer at Freescale=
