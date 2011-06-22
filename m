Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 46ED4B6F53
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Jun 2011 21:09:07 +1000 (EST)
Subject: Re: [PATCH] powerpc/85xx: fix NAND_CMD_READID read bytes number
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1307931792-30386-1-git-send-email-Shaohui.Xie@freescale.com>
Date: Wed, 22 Jun 2011 06:08:49 -0500
Message-Id: <A930A3E6-3999-4240-A40B-03F3A9A5B481@kernel.crashing.org>
References: <1307931792-30386-1-git-send-email-Shaohui.Xie@freescale.com>
To: Shaohui Xie <Shaohui.Xie@freescale.com>
Cc: scottwood@freescale.com, linux-mtd@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 12, 2011, at 9:23 PM, Shaohui Xie wrote:

> when nand_get_flash_type() is called, it will read 8 bytes of ID =
instead of 5,
> but the driver only read 5 bytes, so kernel will dump error messages =
like:
>=20
> fsl-lbc ffe124000.localbus: read_byte beyond end of buffer
> fsl-lbc ffe124000.localbus: read_byte beyond end of buffer
> fsl-lbc ffe124000.localbus: read_byte beyond end of buffer
>=20
> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> Acked-by: Scott Wood <scottwood@freescale.com>
> ---
> drivers/mtd/nand/fsl_elbc_nand.c |    6 +++---
> 1 files changed, 3 insertions(+), 3 deletions(-)

applied to merge

- k=
