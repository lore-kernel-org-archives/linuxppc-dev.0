Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1D5292C00E8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2013 01:59:23 +1000 (EST)
Subject: Re: [PATCH] powerpc/p1010rdb:update phy node in dts
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1378792243-27962-1-git-send-email-B45475@freescale.com>
Date: Tue, 10 Sep 2013 10:59:22 -0500
Message-Id: <BF26D8AA-103B-4824-88AD-085C7DE3D5B0@kernel.crashing.org>
References: <1378792243-27962-1-git-send-email-B45475@freescale.com>
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


On Sep 10, 2013, at 12:50 AM, Zhao Qiang wrote:

> Update phy node according to new P1010RDB-PB board.
>=20
> Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> Signed-off-by: Zhao Qiang <B45475@freescale.com>
> ---
> arch/powerpc/boot/dts/p1010rdb.dtsi | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

What about the old boards?

- k

>=20
> diff --git a/arch/powerpc/boot/dts/p1010rdb.dtsi =
b/arch/powerpc/boot/dts/p1010rdb.dtsi
> index 7fc3402..8c675bf 100644
> --- a/arch/powerpc/boot/dts/p1010rdb.dtsi
> +++ b/arch/powerpc/boot/dts/p1010rdb.dtsi
> @@ -199,7 +199,7 @@
>=20
> 	mdio@24000 {
> 		phy0: ethernet-phy@0 {
> -			interrupts =3D <3 1 0 0>;
> +			interrupts =3D <0 1 0 0>;
> 			reg =3D <0x1>;
> 		};
>=20
> @@ -209,7 +209,7 @@
> 		};
>=20
> 		phy2: ethernet-phy@2 {
> -			interrupts =3D <2 1 0 0>;
> +			interrupts =3D <1 1 0 0>;
> 			reg =3D <0x2>;
> 		};
>=20
> --=20
> 1.8.0
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
