Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E3A94DDE1E
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 13:38:12 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l4N3c7rh011379
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 20:38:08 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l4N3c6lb011088
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 22:38:07 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [PATCH 2/5] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
Date: Wed, 23 May 2007 11:38:05 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C234A2F@zch01exm26.fsl.freescale.net>
In-Reply-To: <465354A0.5020502@freescale.com>
References: <11798051102658-git-send-email-wei.zhang@freescale.com>	<11798051101543-git-send-email-wei.zhang@freescale.com>
	<1179805110272-git-send-email-wei.zhang@freescale.com>
	<465354A0.5020502@freescale.com>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Xiao Xianghua-R6AADS" <x.xiao@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Xianghua,=20

> -----Original Message-----
> From: xianghua xiao [mailto:x.xiao@freescale.com]=20
> Subject: Re: [PATCH 2/5] Add uli1575 pci-bridge sector to=20
> MPC8641HPCN dts file.
>=20
> where is the new uli1575 node referred except for this added snippet?
> thanks,
> xianghua

There're no other places now. You means the 'uli1757:' must be removed?

Thanks!
Wei

>=20
> Zhang Wei wrote:
>=20
> >Add uli1575 pci-bridge sector. It fixes the issue of ULI1575=20
> not found on rev.2 board.
> >
> >Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
> >---
> > arch/powerpc/boot/dts/mpc8641_hpcn.dts      |    6 ++++++
> > arch/powerpc/boot/dts/mpc8641_hpcn_srio.dts |    6 ++++++
> > 2 files changed, 12 insertions(+), 0 deletions(-)
> >
> >diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts=20
> b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> >index 260b264..04626b1 100644
> >--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> >+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> >@@ -297,6 +297,12 @@
> > 				interrupts =3D <49 2>;
> > 				interrupt-parent =3D <&mpic>;
> > 			};
> >+			uli1575: uli1575@100 {
> >+				reg =3D <0 0 0 0 0>;
> >+				pci_bridge@200 {
> >+					reg =3D <0 0 0 0 0>;
> >+				};
> >+			};
> >=20
> > 		};
> >=20
> > =20
> >
>=20
>=20
