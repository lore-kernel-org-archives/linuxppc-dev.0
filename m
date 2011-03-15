Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 35DDFB7005
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Mar 2011 02:07:17 +1100 (EST)
Subject: Re: [PATCH] ppc, 82xx: rename and update mgcoge board support
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1299757965-10235-1-git-send-email-holger.brunck@keymile.com>
Date: Tue, 15 Mar 2011 10:07:07 -0500
Message-Id: <F28DEB67-F265-4C9C-9A9F-2AE0DD23C767@kernel.crashing.org>
References: <1299757965-10235-1-git-send-email-holger.brunck@keymile.com>
To: Holger Brunck <holger.brunck@keymile.com>
Cc: Heiko Schocher <hs@denx.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 10, 2011, at 5:52 AM, Holger Brunck wrote:

> The mgcoge board from keymile is now base for some other
> similar boards. Therefore the board specific name mgcoge
> was renamed to a generic name km82xx. Additionally some
> enhancements were made:
> 	- rework partition table in dts file
> 	- add cpm2_pio_c gpio controller in dts file
> 	- update defconfig
> 	- add pin description for SCC1
> 	- add pin description and configuration for USB
>=20
> Signed-off-by: Holger Brunck <holger.brunck@keymile.com>
> Acked-by: Heiko Schocher <hs@denx.de>
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: Kumar Gala <galak@kernel.crashing.org>
> CC: Heiko Schocher <hs@denx.de>
>=20
> ---
> arch/powerpc/boot/dts/mgcoge.dts                   |   47 =
++++++++-------
> arch/powerpc/configs/mgcoge_defconfig              |    9 +---
> arch/powerpc/platforms/82xx/Makefile               |    2 +-
> arch/powerpc/platforms/82xx/{mgcoge.c =3D> km82xx.c} |   62 =
++++++++++++++------
> 4 files changed, 72 insertions(+), 48 deletions(-)
> rename arch/powerpc/platforms/82xx/{mgcoge.c =3D> km82xx.c} (69%)

applied

- k=
