Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 98181B7D45
	for <linuxppc-dev@ozlabs.org>; Wed,  5 May 2010 03:20:48 +1000 (EST)
Subject: Re: [PATCH 1/2] powerpc/8610: add probing for individual DMA channels,
	not just DMA controllers
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1272923655-31807-1-git-send-email-timur@freescale.com>
Date: Tue, 4 May 2010 12:20:13 -0500
Message-Id: <2928D88F-057B-498C-8A11-F7193429A90D@freescale.com>
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

Acked-by: Kumar Gala <galak@kernel.crashing.org>

- k=
