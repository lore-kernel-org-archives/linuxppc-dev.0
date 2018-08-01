Return-Path: <yangbo.lu@nxp.com>
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-eopbgr60067.outbound.protection.outlook.com [40.107.6.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gTZv222lzF31K
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 20:10:29 +1000 (AEST)
From: "Y.b. Lu" <yangbo.lu@nxp.com>
To: Richard Cochran <richardcochran@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Madalin-cristian Bucur
 <madalin.bucur@nxp.com>, Rob Herring <robh+dt@kernel.org>, Shawn Guo
 <shawnguo@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] ptp_qoriq: convert to use module parameters for
 initialization
Date: Wed, 1 Aug 2018 10:10:24 +0000
Message-ID: <DB6PR0401MB2536CE4BCEE872F2C4D63710F82D0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
References: <20180730100154.27906-1-yangbo.lu@nxp.com>
 <20180730100154.27906-3-yangbo.lu@nxp.com>
 <20180730143043.qu66ttzwyjbw6si7@localhost>
 <DB6PR0401MB253643010802739AD55820F3F82D0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
 <20180801061515.krn52iaq2kqdi3wo@localhost>
In-Reply-To: <20180801061515.krn52iaq2kqdi3wo@localhost>
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

Hi Richard,

> -----Original Message-----
> From: Richard Cochran [mailto:richardcochran@gmail.com]
> Sent: Wednesday, August 1, 2018 2:15 PM
> To: Y.b. Lu <yangbo.lu@nxp.com>
> Cc: netdev@vger.kernel.org; Madalin-cristian Bucur
> <madalin.bucur@nxp.com>; Rob Herring <robh+dt@kernel.org>; Shawn Guo
> <shawnguo@kernel.org>; David S . Miller <davem@davemloft.net>;
> devicetree@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 3/3] ptp_qoriq: convert to use module parameters for
> initialization
>=20
> On Wed, Aug 01, 2018 at 04:36:40AM +0000, Y.b. Lu wrote:
>=20
> > Could I add a function to calculate a set of default register values
> > to initialize ptp timer when dts method failed to get required
> > properties in driver?
>=20
> Yes, it would be ideal if the driver can pick correct values automaticall=
y.
>=20
> However, the frequency on the FIPER outputs can't be configured
> automatically, and we don't have an API for the user to choose this.

[Y.b. Lu] Thanks a lot. Just let me send out the v2 patch for your reviewin=
g.

>=20
> > I think this will be useful. The ptp timer on new platforms (you may
> > see two dts patches in this patchset. Many platforms will be
> > affected.) will work without these dts properties. If user want
> > specific setting, they can set dts properties.
>=20
> Sure.
>=20
> Thanks,
> Richard
