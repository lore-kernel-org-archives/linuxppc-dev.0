Return-Path: <kumar.gala@freescale.com>
Received: from VA3EHSOBE006.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id 1EEC8B70AB
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 23:51:39 +1000 (EST)
Subject: Re: [PATCH] asoc/multi-component: fsl: add support for disabled SSI
	nodes
MIME-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1280962268-31407-1-git-send-email-timur@freescale.com>
Date: Thu, 5 Aug 2010 08:51:05 -0500
Message-ID: <6CD92477-08F6-442D-A5AF-9383A69F23F3@freescale.com>
References: <1280962268-31407-1-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 4, 2010, at 5:51 PM, Timur Tabi wrote:

> Add support for adding "status =3D disabled" to an SSI node to =
incidate that it
> is not wired on the board.  This replaces the not-so-intuitive =
previous method
> of omitting a codec-handle property.
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>=20
> Kumar, would you please ACK the device-tree portion of this patch?  I =
want
> it to go through the ALSA tree.
>=20
> arch/powerpc/boot/dts/mpc8610_hpcd.dts |    1 +
> sound/soc/fsl/fsl_ssi.c                |   13 ++++++++++---
> 2 files changed, 11 insertions(+), 3 deletions(-)

Acked-by: Kumar Gala <galak@kernel.crashing.org>

- k=
