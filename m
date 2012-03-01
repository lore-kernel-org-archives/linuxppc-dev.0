Return-Path: <B32579@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 48092B6EEA
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Mar 2012 13:25:57 +1100 (EST)
From: Kushwaha Prabhakar-B32579 <B32579@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, "dedekind1@gmail.com"
 <dedekind1@gmail.com>
Subject: RE: [PATCH][v3] NAND Machine support for Integrated Flash Controller
Date: Thu, 1 Mar 2012 02:25:46 +0000
Message-ID: <071A08F2C6A57E4E94D980ECA553F874566564@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1327063925-3580-1-git-send-email-prabhakar@freescale.com>
In-Reply-To: <1327063925-3580-1-git-send-email-prabhakar@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Aggrwal Poonam-B10812 <B10812@freescale.com>,
 Li Yang-R58472 <r58472@freescale.com>, Liu Shuo-B35362 <B35362@freescale.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 Dipen Dudhat <Dipen.Dudhat@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Kumar,

This patch is supposed to be pushed via powerpc.git repository to main-line=
.
Because of dependent patch in powerpc/mpc85xx: " powerpc/fsl: Add support f=
or Integrated Flash Controller support"
And it is already picked by you.
	Commit ID: a20cbdeffce247a2b6fb83cd8d22433994068565

So, can you please pick this patch in powerpc.git for future main-line pull=
 request as early as possible.
It will avoid future rebasing of this :)

Regards,
Prabhakar

> -----Original Message-----
> From: Kushwaha Prabhakar-B32579
> Sent: Friday, January 20, 2012 6:22 PM
> To: linuxppc-dev@lists.ozlabs.org; linux-mtd@lists.infradead.org
> Cc: Kushwaha Prabhakar-B32579; Dipen Dudhat; Wood Scott-B07421; Li Yang-
> R58472; Liu Shuo-B35362; Aggrwal Poonam-B10812
> Subject: [PATCH][v3] NAND Machine support for Integrated Flash Controller
>=20
> Integrated Flash Controller(IFC) can be used to hook NAND Flash chips
> using NAND Flash Machine available on it.
>=20
> Signed-off-by: Dipen Dudhat <Dipen.Dudhat@freescale.com>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Liu Shuo <b35362@freescale.com>
> Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> ---
>  Based upon
> git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git (branch
> next)
>=20
>  Tested on P1010RDB
>=20
>  Changes for v2: Ported IFC driver for linux-3.2.0-rc3
> 	- Use chip->bbt_options for BBT
> 	- Use mtd_device_parse_register instead of old parse_mtd_partitions
>=20
>   Changes for v3: Squashed following patch to make singe NAND driver
> patch
> 	- mtd/nand:Fix wrong usage of is_blank() in fsl_ifc_run_command
> 		http://patchwork.ozlabs.org/patch/136547/
> 	- mtd/nand: Fix IFC driver to support 2K NAND page
> 		http://patchwork.ozlabs.org/patch/135010/
>=20
