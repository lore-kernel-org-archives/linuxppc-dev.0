Return-Path: <madalin.bucur@nxp.com>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0081.outbound.protection.outlook.com [104.47.0.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zM8WT301FzF0TD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 01:25:24 +1100 (AEDT)
From: Madalin-cristian Bucur <madalin.bucur@nxp.com>
To: "David S . Miller" <davem@davemloft.net>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "madskateman@gmail.com"
 <madskateman@gmail.com>, Madalin-cristian Bucur <madalin.bucur@nxp.com>,
 Andrew Lunn <andrew@lunn.ch>, Joakim Tjernlund
 <Joakim.Tjernlund@infinera.com>
Subject: RE: DPAA Ethernet traffice troubles with Linux kernel
Date: Wed, 17 Jan 2018 14:24:57 +0000
Message-ID: <DB3PR0402MB3849865056493075A4F4317CECE90@DB3PR0402MB3849.eurprd04.prod.outlook.com>
References: <CAHkrCmFCzPd_a1UmyfuZHKM4hXvou0uO0FYoG5bd_fxE8QMueg@mail.gmail.com>
 <DB3PR0402MB3849EEF00D71FF7A230B70C3ECEB0@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <1516035556.18795.71.camel@infinera.com> <20180116143836.GC22903@lunn.ch>
 <1516125454.18795.87.camel@infinera.com> <20180116205342.GA29888@lunn.ch>
 <1516189651.18795.99.camel@infinera.com> <20180117134339.GC32299@lunn.ch>
 <DB3PR0402MB3849850266808EC52F88A783ECE90@DB3PR0402MB3849.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3849850266808EC52F88A783ECE90@DB3PR0402MB3849.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: netdev-owner@vger.kernel.org [mailto:netdev-owner@vger.kernel.org]
> On Behalf Of Madalin-cristian Bucur
> Sent: Wednesday, January 17, 2018 4:16 PM
> To: Andrew Lunn <andrew@lunn.ch>; Joakim Tjernlund
> <Joakim.Tjernlund@infinera.com>
> Cc: linuxppc-dev@lists.ozlabs.org; netdev@vger.kernel.org;
> madskateman@gmail.com; David S . Miller <davem@davemloft.net>
> Subject: RE: DPAA Ethernet traffice troubles with Linux kernel
>=20
> > -----Original Message-----
> > From: Andrew Lunn [mailto:andrew@lunn.ch]
> > Sent: Wednesday, January 17, 2018 3:44 PM
> > To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
> > Subject: Re: DPAA Ethernet traffice troubles with Linux kernel
> >
> > > That doesn't work really, having users to hit the bug, debug it, fix
> it
> > and then
> > > find it fixed already in upstream, then specifically request it to be
> > backported to stable.
> > > I don't need this fix to be backported, already got it. Someone else
> > might though.
> >
> > The "someone else might though" is a big point of asking for it to
> > added to stable. The other reason is it means one less patch you need
> > to maintain in your build.
>=20
> I've sent that patch [1] for net but I guess the timing was wrong and
> it was merged to net-next.
>=20
> > > I would be interested in bug fixes upstream which fixes:
> >
> > Did you try upstream? Does it give the same errors?
> >
> >     Andrew
>=20
> [1] https://patchwork.kernel.org/patch/10146119/
>=20
> Madalin

Hi Dave,

Can you please add the fix [1] to stable?

Thank you,
Madalin
