Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 334242C00DA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Sep 2013 01:13:20 +1000 (EST)
Subject: Re: [PATCH] powerpc/p1010rdb:remove interrupts of ethernet-phy in
 device tree
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1378871354-22763-1-git-send-email-B45475@freescale.com>
Date: Wed, 11 Sep 2013 10:12:59 -0500
Message-Id: <CE821871-A927-4A65-AA69-05F63AF2C6A1@kernel.crashing.org>
References: <1378871354-22763-1-git-send-email-B45475@freescale.com>
To: Zhao Qiang <B45475@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 10, 2013, at 10:49 PM, Zhao Qiang wrote:

> Since P1010RDB-PA and P1010RDB-PB boards use different external PHY
> interrupt signals.
> And actually the PHY interrupt is not used effectively with
> corresponding interrupt handler.
> So we can remove the interrupts node without side-effect to comply
> with both P1010RDB-PA and P1010RDB-PB.
>=20
> Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> Signed-off-by: Zhao Qiang <B45475@freescale.com>
> ---
> arch/powerpc/boot/dts/p1010rdb.dtsi | 3 ---
> 1 file changed, 3 deletions(-)
>=20

NAK.  The device tree should represent the HW not what drivers decide to =
do with it.

If different board revs have different interrupt signals than create =
dts's to handle the 2 board revs.

- k
