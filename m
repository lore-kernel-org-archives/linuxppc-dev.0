Return-Path: <B45475@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 17C142C00EE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Sep 2013 13:17:34 +1000 (EST)
From: Zhao Qiang-B45475 <B45475@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, Liu Shengzhou-B36685
 <B36685@freescale.com>
Subject: RE: [PATCH] powerpc/p1010rdb:remove interrupts of ethernet-phy in
 device tree
Date: Fri, 13 Sep 2013 03:17:27 +0000
Message-ID: <36B508A30383C943B69CE30E685EB89CEA34A6@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1378871354-22763-1-git-send-email-B45475@freescale.com>
 <CE821871-A927-4A65-AA69-05F63AF2C6A1@kernel.crashing.org>
 <3F453DDFF675A64A89321A1F35281021ABA9F8@039-SN1MPN1-004.039d.mgd.msft.net>
 <D8AFFF30-31B1-4B3B-B9D0-DC209A5A3BCD@kernel.crashing.org>
In-Reply-To: <D8AFFF30-31B1-4B3B-B9D0-DC209A5A3BCD@kernel.crashing.org>
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

On Sep 13, 2013, at 12:42 AM, Kumar Gala wrote:

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Friday, September 13, 2013 12:42 AM
> To: Liu Shengzhou-B36685
> Cc: Zhao Qiang-B45475; linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH] powerpc/p1010rdb:remove interrupts of ethernet-phy
> in device tree
>=20
>=20
> On Sep 12, 2013, at 1:54 AM, Liu Shengzhou-B36685 wrote:
>=20
> >
> >
> >> -----Original Message-----
> >> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> >> Sent: Wednesday, September 11, 2013 11:13 PM
> >> To: Zhao Qiang-B45475
> >> Cc: linuxppc-dev@lists.ozlabs.org; Liu Shengzhou-B36685
> >> Subject: Re: [PATCH] powerpc/p1010rdb:remove interrupts of
> >> ethernet-phy in device tree
> >>
> >>
> >> On Sep 10, 2013, at 10:49 PM, Zhao Qiang wrote:
> >>
> >>
> >> NAK.  The device tree should represent the HW not what drivers decide
> >> to do with it.
> >>
> >> If different board revs have different interrupt signals than create
> >> dts's to handle the 2 board revs.
> >>
> >> - k
> >>
> > You mean we need to create p1010rdb-pa.dtsi and p1010rdb-pb.dtsi
> replacing current p1010rdb.dtsi just because of the unused phy interrupt?
> > and phy interrupt is not present in those dts of P3/P4/P5 platforms.
> > Actually currently many hardware are not present in dts, such as a lot
> of i2c devices, temperature monitor, etc.
> >
> > -Shengzhou
> >
>=20
> I'm saying of the board revs are different w/regards to how the PHY
> interrupt is wired, than create two .dts one for each of the board revs.
>=20
> If the p3/p4/p5 platforms are missing the phy interrupt in the .dts than
> its an error.
>=20
> Other devices like i2c, temp mon, etc should be added.  There is a
> difference between something not existing because people haven't gotten
> around to it / there isn't a binding vs a using the lack of information
> as a configuration mechanism.
>=20
> - k
>=20
>=20

Kumar, please advice your solution, thanks.

-zhaoqiang
