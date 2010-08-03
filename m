Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0C953B6F11
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Aug 2010 22:58:14 +1000 (EST)
Subject: Re: [PATCH 2/3] P4080/mtd: Only make elbc nand driver detect nand
	flash partitions
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1280810714-30639-2-git-send-email-tie-fei.zang@freescale.com>
Date: Tue, 3 Aug 2010 07:58:06 -0500
Message-Id: <CB6DDAC6-620C-4FF1-B006-3E4F3E7A4E17@kernel.crashing.org>
References: <1280810714-30639-1-git-send-email-tie-fei.zang@freescale.com>
	<1280810714-30639-2-git-send-email-tie-fei.zang@freescale.com>
To: Roy Zang <tie-fei.zang@freescale.com>
Cc: Lan Chunhe-B25806 <B25806@freescale.com>,
	"linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 2, 2010, at 11:45 PM, Roy Zang wrote:

> From: Lan Chunhe-B25806 <b25806@freescale.com>
>=20
> The former driver had the two functions:
>=20
> 1. detecting nand flash partitions;
> 2. registering elbc interrupt.
>=20
> Now, second function is removed to fsl_lbc.c.
>=20
> Signed-off-by: Lan Chunhe-B25806 <b25806@freescale.com>
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> ---
> drivers/mtd/nand/Kconfig         |    1 +
> drivers/mtd/nand/fsl_elbc_nand.c |  464 =
++++++++++++++------------------------
> 2 files changed, 170 insertions(+), 295 deletions(-)

mtd list and maintainer should be CC'd on these.

- k=
