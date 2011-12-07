Return-Path: <B38951@freescale.com>
Received: from VA3EHSOBE003.bigfish.com (va3ehsobe003.messaging.microsoft.com
 [216.32.180.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 2D2CD1007D2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2011 18:28:05 +1100 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: RE: [linuxppc-release] [powerpc] boot up problem
Date: Wed, 7 Dec 2011 07:27:58 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5DFE170A@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1320040492-6407-1-git-send-email-B38951@freescale.com>
 <1320040492-6407-2-git-send-email-B38951@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5DFD4DB8@039-SN1MPN1-005.039d.mgd.msft.net>
 <3E825AD9-1CD5-4D6D-8161-E6B4F1D32457@kernel.crashing.org>
 <3F607A5180246847A760FD34122A1E052DBCD1@039-SN1MPN1-003.039d.mgd.msft.net>
 <412C8208B4A0464FA894C5F0C278CD5DFD6BAB@039-SN1MPN1-005.039d.mgd.msft.net>
 <3EC6F9E0-C847-4DA8-AD8C-313976982A10@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5DFDC478@039-SN1MPN1-005.039d.mgd.msft.net>
 <4ED84C32.3010807@freescale.com>
In-Reply-To: <4ED84C32.3010807@freescale.com>
Content-Type: text/plain; charset="us-ascii"
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

Is this the patch you mentioned?
http://patchwork.ozlabs.org/patch/128806/

I applied this patch but the issue was still there.

-----Original Message-----
From: Tabi Timur-B04825=20
Sent: Friday, December 02, 2011 11:56 AM
To: Jia Hongtao-B38951
Cc: Kumar Gala; linuxppc-dev@lists.ozlabs.org; Li Yang-R58472; Fleming Andy=
-AFLEMING
Subject: Re: [linuxppc-release] [powerpc] boot up problem

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
> Unable to handle kernel paging request for data at address 0x00000000=20
> Faulting instruction address: 0xc0451630
> Oops: Kernel access of bad area, sig: 11 [#1]

Andy has phy driver patch that fixes this.

--
Timur Tabi
Linux kernel developer at Freescale
