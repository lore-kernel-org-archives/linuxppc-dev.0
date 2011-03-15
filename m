Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ADFEEB7005
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Mar 2011 02:07:15 +1100 (EST)
Subject: Re: [PATCH] ppc, 83xx: rename and update kmeter1
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1299826964-3846-1-git-send-email-holger.brunck@keymile.com>
Date: Tue, 15 Mar 2011 10:07:00 -0500
Message-Id: <2018AFAF-9279-4416-8135-08CE6E2B58F0@kernel.crashing.org>
References: <1299826964-3846-1-git-send-email-holger.brunck@keymile.com>
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


On Mar 11, 2011, at 1:02 AM, Holger Brunck wrote:

> Beside the MPC 8360 based board kmeter1 other km83xx boards
> from keymile will follow. Therefore the board specific naming
> kmeter1 for functions and files were replaced with km83xx.
> Additionally some updates were made:
>    - update defconfig for 2.6.38
>    - rework flash partitioning in dts file
>    - add gpio controller for qe_pio_c in dts
>=20
> Signed-off-by: Holger Brunck <holger.brunck@keymile.com>
> Acked-by: Heiko Schocher <hs@denx.de>
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: Kumar Gala <galak@kernel.crashing.org>
> CC: Heiko Schocher <hs@denx.de>
> ---
> arch/powerpc/boot/dts/kmeter1.dts                  |   69 =
+++++++++++---------
> arch/powerpc/configs/83xx/kmeter1_defconfig        |    7 +--
> arch/powerpc/platforms/83xx/Makefile               |    2 +-
> .../powerpc/platforms/83xx/{kmeter1.c =3D> km83xx.c} |   46 =
+++++++++----
> 4 files changed, 71 insertions(+), 53 deletions(-)
> rename arch/powerpc/platforms/83xx/{kmeter1.c =3D> km83xx.c} (80%)

applied

- k=
