Return-Path: <B36685@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E554A2C039B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Sep 2013 16:54:25 +1000 (EST)
From: Liu Shengzhou-B36685 <B36685@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, Zhao Qiang-B45475
 <B45475@freescale.com>
Subject: RE: [PATCH] powerpc/p1010rdb:remove interrupts of ethernet-phy in
 device tree
Date: Thu, 12 Sep 2013 06:54:13 +0000
Message-ID: <3F453DDFF675A64A89321A1F35281021ABA9F8@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1378871354-22763-1-git-send-email-B45475@freescale.com>
 <CE821871-A927-4A65-AA69-05F63AF2C6A1@kernel.crashing.org>
In-Reply-To: <CE821871-A927-4A65-AA69-05F63AF2C6A1@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Wednesday, September 11, 2013 11:13 PM
> To: Zhao Qiang-B45475
> Cc: linuxppc-dev@lists.ozlabs.org; Liu Shengzhou-B36685
> Subject: Re: [PATCH] powerpc/p1010rdb:remove interrupts of ethernet-phy i=
n
> device tree
>=20
>=20
> On Sep 10, 2013, at 10:49 PM, Zhao Qiang wrote:
>=20
> > Since P1010RDB-PA and P1010RDB-PB boards use different external PHY
> > interrupt signals.
> > And actually the PHY interrupt is not used effectively with
> > corresponding interrupt handler.
> > So we can remove the interrupts node without side-effect to comply
> > with both P1010RDB-PA and P1010RDB-PB.
> >
> > Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> > Signed-off-by: Zhao Qiang <B45475@freescale.com>
> > ---
> > arch/powerpc/boot/dts/p1010rdb.dtsi | 3 ---
> > 1 file changed, 3 deletions(-)
> >
>=20
> NAK.  The device tree should represent the HW not what drivers decide to =
do with
> it.
>=20
> If different board revs have different interrupt signals than create dts'=
s to
> handle the 2 board revs.
>=20
> - k
>=20
You mean we need to create p1010rdb-pa.dtsi and p1010rdb-pb.dtsi replacing =
current p1010rdb.dtsi just because of the unused phy interrupt?
and phy interrupt is not present in those dts of P3/P4/P5 platforms.
Actually currently many hardware are not present in dts, such as a lot of i=
2c devices, temperature monitor, etc.

-Shengzhou
