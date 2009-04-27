Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8016BDDD0C
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 05:36:24 +1000 (EST)
Message-Id: <2CE2BC61-1C6B-4D01-870B-BC460730AD79@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: =?ISO-8859-1?Q?Rog=E9rio_Brito?= <rbrito@ime.usp.br>
In-Reply-To: <20090424223355.GB7858@ime.usp.br>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] powerpc: minimizing the configuration of
	linkstation_defconfig
Date: Mon, 27 Apr 2009 14:29:52 -0500
References: <20090424065816.GA15525@ime.usp.br>
	<Pine.LNX.4.64.0904242158210.8309@axis700.grange>
	<20090424223355.GB7858@ime.usp.br>
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 24, 2009, at 5:33 PM, Rog=E9rio Brito wrote:

> This patch addresses the following issues:
>
>
> 01. makes CFQ the default scheduler, to be in line with the rest of =20=

> the kernel.
>
> 02. since linkstations are meant to store files, enable large blk =20
> devices.
>
> 03. disable CONFIG_MIGRATION in in such low memory devices.
>
> 04. disable CONFIG_BLK_DEV_RAM.

do we not allow booting a ramdisk?

> 05. disable CONFIG_SCSI_LOWLEVEL, as no device under that tree is =20
> used.
>
> 06. idem for CONFIG_NETDEV_10000.
>
> 07. idem for CONFIG_WIRELESS.
>
> 08. idem for CONFIG_HWMON.
>
> 09. idem for CONFIG_CRYPTO_HW.
>
> 10. disable CONFIG_VIDEO_OUTPUT_CONTROL.
>
> 11. keep consistency and disable extended attributes in CIFS, ext3, =20=

> and NFS.
>
> 12. enable CONFIG_PRINTK_TIME.
>
> Signed-off-by: Rog=E9rio Brito <rbrito@ime.usp.br>
>
> ---
>
> Dear Kumar, please, apply this one.
>
> I have another patch regarding one regression regarding MTD &
> PHYSMAP_COMPAT that I plan to send on top of this one.
>
> Thanks.

Ok, can we look at just specifying such info in the linkstation device =20=

tree.

Also, can you break this defconfig update into two patches.  1. that =20
just updates to 2.6.30-rc3 (or latest) and 2. that makes the various =20
changes you've listed above.

- k=
