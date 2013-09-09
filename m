Return-Path: <B36685@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0248.outbound.messaging.microsoft.com [213.199.154.248])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 51D6D2C0115
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Sep 2013 13:57:16 +1000 (EST)
Received: from mail63-db9 (localhost [127.0.0.1])	by mail63-db9-R.bigfish.com
 (Postfix) with ESMTP id DB0988800E3	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Sep 2013 03:57:09 +0000 (UTC)
Received: from DB9EHSMHS002.bigfish.com (unknown [10.174.16.241])	by
 mail63-db9.bigfish.com (Postfix) with ESMTP id B128A64004C	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Sep 2013 03:57:07 +0000 (UTC)
From: Liu Shengzhou-B36685 <B36685@freescale.com>
To: Xie Xiaobo-R63061 <r63061@freescale.com>, Wood Scott-B07421
 <B07421@freescale.com>
Subject: RE: [PATCH V3 2/2] powerpc/85xx: Add TWR-P1025 board support
Date: Mon, 9 Sep 2013 03:57:05 +0000
Message-ID: <3F453DDFF675A64A89321A1F35281021AB8BBA@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1378116699-18826-1-git-send-email-X.Xie@freescale.com>
 <1378116699-18826-2-git-send-email-X.Xie@freescale.com>
 <1378311953.12204.20.camel@snotra.buserror.net>
 <69EC9ED88E3CC04094A78F8074A7986D5D23CE@039-SN1MPN1-003.039d.mgd.msft.net>
In-Reply-To: <69EC9ED88E3CC04094A78F8074A7986D5D23CE@039-SN1MPN1-003.039d.mgd.msft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Johnston Michael-R49610 <r49610@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Xiaobo,

You can use interrupts =3D <1 1 0 0> instead of interrupts =3D <1 1> with t=
est on P1025twr.
It was mislead by hardware issue on p1010rdb-pb board.

Regards,
Shengzhou

> -----Original Message-----
> From: Linuxppc-dev [mailto:linuxppc-dev-
> bounces+shengzhou.liu=3Dfreescale.com@lists.ozlabs.org] On Behalf Of Xie =
Xiaobo-
> R63061
> Sent: Friday, September 06, 2013 6:01 PM
> To: Wood Scott-B07421
> Cc: Johnston Michael-R49610; linuxppc-dev@lists.ozlabs.org
> Subject: RE: [PATCH V3 2/2] powerpc/85xx: Add TWR-P1025 board support
>=20
> Hi Scott,
>=20
> Thanks for your reminding and advice.
>=20
> I discuss this with Liu Shengzhou(the first person that remind me #interr=
upt-
> cells is 4), he advised removing the interrupts property from the phy nod=
e,
> because the mdio used the poll way preferentially.
>=20
> Best Regards
> Xie Xiaobo
>=20
> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Thursday, September 05, 2013 12:26 AM
> To: Xie Xiaobo-R63061
> Cc: linuxppc-dev@lists.ozlabs.org; galak@kernel.crashing.org; Johnston Mi=
chael-
> R49610
> Subject: Re: [PATCH V3 2/2] powerpc/85xx: Add TWR-P1025 board support
>=20
> On Mon, 2013-09-02 at 18:11 +0800, Xie Xiaobo wrote:
> > +&soc {
> > +	usb@22000 {
> > +		phy_type =3D "ulpi";
> > +	};
> > +
> > +	mdio@24000 {
> > +		phy0: ethernet-phy@2 {
> > +			interrupt-parent =3D <&mpic>;
> > +			interrupts =3D <1 1>;
> > +			reg =3D <0x2>;
> > +		};
> > +
> > +		phy1: ethernet-phy@1 {
> > +			interrupt-parent =3D <&mpic>;
> > +			interrupts =3D <2 1>;
> > +			reg =3D <0x1>;
> > +		};
>=20
> Again, #interrupt-cells is 4.
>=20
> Please respond to feedback rather than ignoring it and reposting the same=
 thing
> without comment.
>=20
> -Scott
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
