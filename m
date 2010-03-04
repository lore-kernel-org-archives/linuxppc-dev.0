Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E2D25B7CFB
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Mar 2010 03:45:12 +1100 (EST)
Subject: Re: [PATCH] powerpc: Renaming following split of GE Fanuc joint
	venture
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <20100301144159.23431.18196.stgit@ES-J7S4D2J.amer.consind.ge.com>
Date: Thu, 4 Mar 2010 10:45:07 -0600
Message-Id: <67658FCF-9A61-48E1-8E38-9F450DE8923A@freescale.com>
References: <20100301144159.23431.18196.stgit@ES-J7S4D2J.amer.consind.ge.com>
To: Martyn Welch <martyn.welch@ge.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 1, 2010, at 8:41 AM, Martyn Welch wrote:

> This patch renames GE Fanuc boards following the split-up of the GE =
Fanuc joint venture. These boards are now made by GE Intelligent =
platorms.
>=20
> Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
> ---
>=20
> arch/powerpc/boot/dts/gef_ppc9a.dts      |    4 ++--
> arch/powerpc/boot/dts/gef_sbc310.dts     |    4 ++--
> arch/powerpc/boot/dts/gef_sbc610.dts     |    4 ++--
> arch/powerpc/platforms/86xx/Kconfig      |   12 ++++++------
> arch/powerpc/platforms/86xx/gef_gpio.c   |   10 +++++-----
> arch/powerpc/platforms/86xx/gef_pic.c    |    6 +++---
> arch/powerpc/platforms/86xx/gef_ppc9a.c  |   12 ++++++------
> arch/powerpc/platforms/86xx/gef_sbc310.c |   12 ++++++------
> arch/powerpc/platforms/86xx/gef_sbc610.c |   12 ++++++------
> 9 files changed, 38 insertions(+), 38 deletions(-)

applied to next

- k=
