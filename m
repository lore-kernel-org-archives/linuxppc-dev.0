Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 48ADFB7F4F
	for <linuxppc-dev@ozlabs.org>; Tue, 18 May 2010 01:56:30 +1000 (EST)
Subject: Re: [PATCH 1/2] powerpc/8610: add probing for individual DMA channels,
	not just DMA controllers
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1272923655-31807-1-git-send-email-timur@freescale.com>
Date: Mon, 17 May 2010 10:55:58 -0500
Message-Id: <25917C45-84C0-4E87-A4BE-0E70B82BFB0B@freescale.com>
References: <1272923655-31807-1-git-send-email-timur@freescale.com>
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


On May 3, 2010, at 4:54 PM, Timur Tabi wrote:

> A future version of the MPC8610 HPCD's ASoC DMA driver will probe on =
individual
> DMA channel nodes, so the DMA controller nodes' compatible string must =
be listed
> in mpc8610_ids[] for the probe to work.
>=20
> Also remove the "gianfar" compatible from mpc8610_ids[], since there =
is no
> gianfar (or any other networking device) on the 8610.
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>=20
> Kumar, the ASoC mainters are willing to pick up this patch, but they =
want an
> ACK from you first.  Or, you could pick it up, since by itself it's =
harmless.
>=20
> arch/powerpc/platforms/86xx/mpc8610_hpcd.c |    3 ++-
> 1 files changed, 2 insertions(+), 1 deletions(-)

applied to next

- k=
