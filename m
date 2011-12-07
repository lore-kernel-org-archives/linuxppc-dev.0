Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2C082B7090
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Dec 2011 01:53:27 +1100 (EST)
Subject: Re: [linuxppc-release] [powerpc] boot up problem
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5DFE170A@039-SN1MPN1-005.039d.mgd.msft.net>
Date: Wed, 7 Dec 2011 08:53:32 -0600
Message-Id: <F3AED504-1246-4D74-967E-EB3D760492BA@kernel.crashing.org>
References: <1320040492-6407-1-git-send-email-B38951@freescale.com>
 <1320040492-6407-2-git-send-email-B38951@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5DFD4DB8@039-SN1MPN1-005.039d.mgd.msft.net>
 <3E825AD9-1CD5-4D6D-8161-E6B4F1D32457@kernel.crashing.org>
 <3F607A5180246847A760FD34122A1E052DBCD1@039-SN1MPN1-003.039d.mgd.msft.net>
 <412C8208B4A0464FA894C5F0C278CD5DFD6BAB@039-SN1MPN1-005.039d.mgd.msft.net>
 <3EC6F9E0-C847-4DA8-AD8C-313976982A10@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5DFDC478@039-SN1MPN1-005.039d.mgd.msft.net>
 <4ED84C32.3010807@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5DFE170A@039-SN1MPN1-005.039d.mgd.msft.net>
To: Jia Hongtao-B38951 <B38951@freescale.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Fleming Andy-AFLEMING <afleming@freescale.com>,
 Tabi Timur-B04825 <B04825@freescale.com>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This still needs a dts fix from Andy.

- k

On Dec 7, 2011, at 1:27 AM, Jia Hongtao-B38951 wrote:

> Is this the patch you mentioned?
> http://patchwork.ozlabs.org/patch/128806/
>=20
> I applied this patch but the issue was still there.
>=20
> -----Original Message-----
> From: Tabi Timur-B04825=20
> Sent: Friday, December 02, 2011 11:56 AM
> To: Jia Hongtao-B38951
> Cc: Kumar Gala; linuxppc-dev@lists.ozlabs.org; Li Yang-R58472; Fleming =
Andy-AFLEMING
> Subject: Re: [linuxppc-release] [powerpc] boot up problem
>=20
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
>> Unable to handle kernel paging request for data at address 0x00000000=20=

>> Faulting instruction address: 0xc0451630
>> Oops: Kernel access of bad area, sig: 11 [#1]
>=20
> Andy has phy driver patch that fixes this.
>=20
> --
> Timur Tabi
> Linux kernel developer at Freescale
