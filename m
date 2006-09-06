Return-Path: <tanya.jiang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id C454167B7E
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Sep 2006 17:36:29 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k868tcMc029189
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Sep 2006 02:55:38 -0600 (MDT)
Received: from zch01exm24.fsl.freescale.net (zch01exm24.ap.freescale.net
	[10.192.129.208])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k867aMfI028408
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Sep 2006 02:36:23 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 4/4] Add MPC8349E MDS device tree source file
	toarch/powerpc/boot/dts
Date: Wed, 6 Sep 2006 15:36:21 +0800
Message-ID: <5B3767CDCE2C2B46B2BCB72C4833E888369060@zch01exm24.fsl.freescale.net>
In-Reply-To: <20060825115947.0d9ad52f.kim.phillips@freescale.com>
From: "Jiang Bo-r61859" <tanya.jiang@freescale.com>
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

=20

>-----Original Message-----
>Add MPC8349E MDS device tree source file to=20
>arch/powerpc/boot/dts, aptly indicating new school sense=20
>values definition.
>
> arch/powerpc/boot/dts/mpc8349emds.dts |  328=20
>+++++++++++++++++++++++++++++++++
> 1 files changed, 328 insertions(+), 0 deletions(-)
>+			device_type =3D "serial";
>+		pci@8500 {
>+			interrupt-map-mask =3D <f800 0 0 7>;
>+			interrupt-map =3D <
>+
>+					/* IDSEL 0x11 */
>+					 8800 0 0 1 700 14 0
>+					 8800 0 0 2 700 15 0
>+					 8800 0 0 3 700 16 0
>+					 8800 0 0 4 700 17 0
snip
>+
>+					/* IDSEL 0x18 */
>+					 b000 0 0 1 700 15 0
>+					 b000 0 0 2 700 16 0
>+					 b000 0 0 3 700 17 0
>+					 b000 0 0 4 700 14 0>;
snip

If it is about IDSEL 0x18, b000 should be c000

>+
>+		pci@8600 {
>+			interrupt-map-mask =3D <f800 0 0 7>;
>+			interrupt-map =3D <
>+
snip
>+					/* IDSEL 0x18 */
>+					 b000 0 0 1 700 15 0
>+					 b000 0 0 2 700 16 0
>+					 b000 0 0 3 700 17 0
>+					 b000 0 0 4 700 14 0>;
Same problem.
>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
