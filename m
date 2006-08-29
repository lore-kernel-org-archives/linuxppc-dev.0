Return-Path: <DaveLiu@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 2C67867B6F
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2006 12:33:03 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k7T2jIdl004710
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Aug 2006 19:45:18 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k7T2WxRH006335
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Aug 2006 21:33:01 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] corrected PCI interrupt sense values to level low
	inmpc8349emds.dts
Date: Tue, 29 Aug 2006 10:32:58 +0800
Message-ID: <995B09A8299C2C44B59866F6391D263511BA03@zch01exm21.fsl.freescale.net>
In-Reply-To: <20060828174910.236bf042.kim.phillips@freescale.com>
From: "Liu Dave-r63238" <DaveLiu@freescale.com>
To: "Phillips Kim-R1AAHA" <Kim.Phillips@freescale.com>,
	<linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Corrected PCI interrupt sense values to level low in=20
> mpc8349emds.dts, per Leo's recommendation.
>=20
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
>=20
> applies on top of "[PATCH 4/4] Add MPC8349E MDS device tree=20
> source file to arch/powerpc/boot/dts"
>=20
>=20
>  arch/powerpc/boot/dts/mpc8349emds.dts |  112=20
> +++++++++++++++++----------------
>  1 files changed, 56 insertions(+), 56 deletions(-)
>=20
> diff --git a/arch/powerpc/boot/dts/mpc8349emds.dts=20
> b/arch/powerpc/boot/dts/mpc8349emds.dts
> index 7e4508b..0643db9 100644
> --- a/arch/powerpc/boot/dts/mpc8349emds.dts
> +++ b/arch/powerpc/boot/dts/mpc8349emds.dts
> @@ -178,46 +178,46 @@
>  			interrupt-map =3D <
> =20
>  					/* IDSEL 0x11 */
> -					 8800 0 0 1 700 14 0
> -					 8800 0 0 2 700 15 0
> -					 8800 0 0 3 700 16 0
> -					 8800 0 0 4 700 17 0
> +					 8800 0 0 1 700 14 2
> +					 8800 0 0 2 700 15 2
> +					 8800 0 0 3 700 16 2
> +					 8800 0 0 4 700 17 2
> =20
>  					/* IDSEL 0x12 */
> -					 9000 0 0 1 700 16 0
> -					 9000 0 0 2 700 17 0
> -					 9000 0 0 3 700 14 0
> -					 9000 0 0 4 700 15 0
> +					 9000 0 0 1 700 16 2
> +					 9000 0 0 2 700 17 2
> +					 9000 0 0 3 700 14 2
> +					 9000 0 0 4 700 15 2
> =20
>  					/* IDSEL 0x13 */
> -					 9800 0 0 1 700 17 0
> -					 9800 0 0 2 700 14 0
> -					 9800 0 0 3 700 15 0
> -					 9800 0 0 4 700 16 0
> +					 9800 0 0 1 700 17 2
> +					 9800 0 0 2 700 14 2
> +					 9800 0 0 3 700 15 2
> +					 9800 0 0 4 700 16 2
> =20
>  					/* IDSEL 0x15 */
> -					 a800 0 0 1 700 14 0
> -					 a800 0 0 2 700 15 0
> -					 a800 0 0 3 700 16 0
> -					 a800 0 0 4 700 17 0
> +					 a800 0 0 1 700 14 2
> +					 a800 0 0 2 700 15 2
> +					 a800 0 0 3 700 16 2
> +					 a800 0 0 4 700 17 2
> =20
>  					/* IDSEL 0x16 */
> -					 b000 0 0 1 700 17 0
> -					 b000 0 0 2 700 14 0
> -					 b000 0 0 3 700 15 0
> -					 b000 0 0 4 700 16 0
> +					 b000 0 0 1 700 17 2
> +					 b000 0 0 2 700 14 2
> +					 b000 0 0 3 700 15 2
> +					 b000 0 0 4 700 16 2
> =20
>  					/* IDSEL 0x17 */
> -					 b800 0 0 1 700 16 0
> -					 b800 0 0 2 700 17 0
> -					 b800 0 0 3 700 14 0
> -					 b800 0 0 4 700 15 0
> +					 b800 0 0 1 700 16 2
> +					 b800 0 0 2 700 17 2
> +					 b800 0 0 3 700 14 2
> +					 b800 0 0 4 700 15 2
> =20
>  					/* IDSEL 0x18 */
> -					 b000 0 0 1 700 15 0
> -					 b000 0 0 2 700 16 0
> -					 b000 0 0 3 700 17 0
> -					 b000 0 0 4 700 14 0>;
> +					 b000 0 0 1 700 15 2
> +					 b000 0 0 2 700 16 2
> +					 b000 0 0 3 700 17 2
> +					 b000 0 0 4 700 14 2>;
>  			interrupt-parent =3D <700>;
>  			interrupts =3D <42 8>;
>  			bus-range =3D <0 0>;
> @@ -238,46 +238,46 @@
>  			interrupt-map =3D <
> =20
>  					/* IDSEL 0x11 */
> -					 8800 0 0 1 700 14 0
> -					 8800 0 0 2 700 15 0
> -					 8800 0 0 3 700 16 0
> -					 8800 0 0 4 700 17 0
> +					 8800 0 0 1 700 14 2
> +					 8800 0 0 2 700 15 2
> +					 8800 0 0 3 700 16 2
> +					 8800 0 0 4 700 17 2
> =20
>  					/* IDSEL 0x12 */
> -					 9000 0 0 1 700 16 0
> -					 9000 0 0 2 700 17 0
> -					 9000 0 0 3 700 14 0
> -					 9000 0 0 4 700 15 0
> +					 9000 0 0 1 700 16 2
> +					 9000 0 0 2 700 17 2
> +					 9000 0 0 3 700 14 2
> +					 9000 0 0 4 700 15 2
> =20
>  					/* IDSEL 0x13 */
> -					 9800 0 0 1 700 17 0
> -					 9800 0 0 2 700 14 0
> -					 9800 0 0 3 700 15 0
> -					 9800 0 0 4 700 16 0
> +					 9800 0 0 1 700 17 2
> +					 9800 0 0 2 700 14 2
> +					 9800 0 0 3 700 15 2
> +					 9800 0 0 4 700 16 2
> =20
>  					/* IDSEL 0x15 */
> -					 a800 0 0 1 700 14 0
> -					 a800 0 0 2 700 15 0
> -					 a800 0 0 3 700 16 0
> -					 a800 0 0 4 700 17 0
> +					 a800 0 0 1 700 14 2
> +					 a800 0 0 2 700 15 2
> +					 a800 0 0 3 700 16 2
> +					 a800 0 0 4 700 17 2
> =20
>  					/* IDSEL 0x16 */
> -					 b000 0 0 1 700 17 0
> -					 b000 0 0 2 700 14 0
> -					 b000 0 0 3 700 15 0
> -					 b000 0 0 4 700 16 0
> +					 b000 0 0 1 700 17 2
> +					 b000 0 0 2 700 14 2
> +					 b000 0 0 3 700 15 2
> +					 b000 0 0 4 700 16 2
> =20
>  					/* IDSEL 0x17 */
> -					 b800 0 0 1 700 16 0
> -					 b800 0 0 2 700 17 0
> -					 b800 0 0 3 700 14 0
> -					 b800 0 0 4 700 15 0
> +					 b800 0 0 1 700 16 2
> +					 b800 0 0 2 700 17 2
> +					 b800 0 0 3 700 14 2
> +					 b800 0 0 4 700 15 2
> =20
>  					/* IDSEL 0x18 */
> -					 b000 0 0 1 700 15 0
> -					 b000 0 0 2 700 16 0
> -					 b000 0 0 3 700 17 0
> -					 b000 0 0 4 700 14 0>;
> +					 b000 0 0 1 700 15 2
> +					 b000 0 0 2 700 16 2
> +					 b000 0 0 3 700 17 2
> +					 b000 0 0 4 700 14 2>;
>  			interrupt-parent =3D <700>;
>  			interrupts =3D <42 8>;
>  			bus-range =3D <0 0>;
> --
> 1.4.1

Where these IDSEL 0x15~0x18 come from on 8349EMDS board?
Please expain it.

-DAve
