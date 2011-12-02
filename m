Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1AC69B6F62
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2011 15:12:50 +1100 (EST)
Subject: Re: [linuxppc-release] [powerpc] boot up problem
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=iso-8859-1
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4ED84C32.3010807@freescale.com>
Date: Thu, 1 Dec 2011 22:12:50 -0600
Message-Id: <14C39354-290B-4FA7-B0F4-799F3E2DD920@kernel.crashing.org>
References: <1320040492-6407-1-git-send-email-B38951@freescale.com>
 <1320040492-6407-2-git-send-email-B38951@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5DFD4DB8@039-SN1MPN1-005.039d.mgd.msft.net>
 <3E825AD9-1CD5-4D6D-8161-E6B4F1D32457@kernel.crashing.org>
 <3F607A5180246847A760FD34122A1E052DBCD1@039-SN1MPN1-003.039d.mgd.msft.net>
 <412C8208B4A0464FA894C5F0C278CD5DFD6BAB@039-SN1MPN1-005.039d.mgd.msft.net>
 <3EC6F9E0-C847-4DA8-AD8C-313976982A10@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5DFDC478@039-SN1MPN1-005.039d.mgd.msft.net>
 <4ED84C32.3010807@freescale.com>
To: Andy Fleming <afleming@freescale.com>
Cc: LinuxPPC-dev list <linuxppc-dev@lists.ozlabs.org>,
 Fleming Andy-AFLEMING <afleming@freescale.com>,
 Tabi Timur-B04825 <B04825@freescale.com>,
 Li Yang-R58472 <r58472@freescale.com>,
 Jia Hongtao-B38951 <B38951@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 1, 2011, at 9:55 PM, Tabi Timur-B04825 wrote:

> Jia Hongtao-B38951 wrote:
>> Hi
>>=20
>> I just found that the 'next' branch you mentioned have problem to =
boot up.
>> I test it in p1022ds and p1010rdb boards and the result are both the =
same.
>> Note that for p1022ds I use "make p1022ds.dtb" to make the dtb =
file(36bit) with 36bit-uboot.
>> And for p1010rdb I use all 32bit image.
>> The problem list below:
>>=20
>> scsi0 : sata_fsl
>> ata1: SATA max UDMA/133 irq 74
>> fsl-sata fffe19000.sata: Sata FSL Platform/CSB Driver init
>> scsi1 : sata_fsl
>> ata2: SATA max UDMA/133 irq 41
>> Fixed MDIO Bus: probed
>> Unable to handle kernel paging request for data at address 0x00000000
>> Faulting instruction address: 0xc0451630
>> Oops: Kernel access of bad area, sig: 11 [#1]
>=20
> Andy has phy driver patch that fixes this.

Andy,

What's going on here?  Is there a fix in v3.2-rc4?

- k=
