Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 59937B71D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 12:46:51 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A9C8BDDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 12:46:50 +1000 (EST)
Message-Id: <3167CCB7-E635-416C-AA99-62033E73AF87@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: =?ISO-8859-1?Q?Rog=E9rio_Brito?= <rbrito@ime.usp.br>
In-Reply-To: <20090516160453.GA15138@ime.usp.br>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH] powerpc: minimizing the configuration of
	linkstation_defconfig
Date: Wed, 10 Jun 2009 21:46:38 -0500
References: <20090424065816.GA15525@ime.usp.br>
	<Pine.LNX.4.64.0904242158210.8309@axis700.grange>
	<20090424223355.GB7858@ime.usp.br>
	<2CE2BC61-1C6B-4D01-870B-BC460730AD79@kernel.crashing.org>
	<20090428133200.GB12828@ime.usp.br>
	<20090516160453.GA15138@ime.usp.br>
Cc: linuxppc-dev@ozlabs.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 16, 2009, at 11:04 AM, Rog=E9rio Brito wrote:

> Hi, Kumar, Guennadi, and Co.
>
>
> This patch addresses the following issues:
>
> 01. makes CFQ the default scheduler, to be in line with the rest of
> the kernel.
>
> 02. since linkstations are meant to store files, enable large blk
> devices.
>
> 03. disable CONFIG_MIGRATION in in such low memory devices.
>
> 04. disable CONFIG_BLK_DEV_RAM.
>
> 05. disable CONFIG_SCSI_LOWLEVEL, as no device under that tree is
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
> 11. keep consistency and disable extended attributes in CIFS, ext3,
> and NFS.
>
> 12. enable CONFIG_PRINTK_TIME.
>
> Signed-off-by: Rog=E9rio Brito <rbrito@ime.usp.br>
>
> ---
>
> This is the patch for tidying the defconfig. I'm still having issues
> with the MTD devices, it seems. :-( I will investigate this now.
>
> I can send a similar patch to storcenter.

Did you ever resolve the MTD issue?

- k=
