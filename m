Return-Path: <ran.wang_1@nxp.com>
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr70042.outbound.protection.outlook.com [40.107.7.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 424nYN05xzzF37X
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2018 12:23:02 +1000 (AEST)
From: Ran Wang <ran.wang_1@nxp.com>
To: Rob Herring <robh@kernel.org>
CC: Leo Li <leoyang.li@nxp.com>, Mark Rutland <mark.rutland@arm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] Documentation: dt: binding: fsl: update property
 description for RCPM
Date: Wed, 5 Sep 2018 02:22:55 +0000
Message-ID: <AM5PR0402MB28659BF8C2B5B3B18DB6BAC9F1020@AM5PR0402MB2865.eurprd04.prod.outlook.com>
References: <20180831035219.31619-1-ran.wang_1@nxp.com>
 <20180831035219.31619-2-ran.wang_1@nxp.com>
 <5b8e8a71.1c69fb81.d966f.1ca1@mx.google.com>
In-Reply-To: <5b8e8a71.1c69fb81.d966f.1ca1@mx.google.com>
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

Hi Rob

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Tuesday, September 04, 2018 09:25
> To: Ran Wang <ran.wang_1@nxp.com>
> Cc: Leo Li <leoyang.li@nxp.com>; Mark Rutland <mark.rutland@arm.com>;
> linuxppc-dev@lists.ozlabs.org; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 2/3] Documentation: dt: binding: fsl: update property
> description for RCPM
>=20
> On Fri, Aug 31, 2018 at 11:52:18AM +0800, Ran Wang wrote:
> > Add property 'big-endian' and supportted IP's configuration info.
> > Remove property 'fsl,#rcpm-wakeup-cell'.
>=20
> "dt-bindings: soc: ..." for the subject
>=20
> It is obvious reading the diff you are removing fsl,#rcpm-wakeup-cell.
> What is not obvious is why? The commit msg should answer that.

Sure, I will add this in next version patch.

> You also are mixing several things in this patch like adding ls1012 which=
 you
> don't mention. Please split.

Got it, will split them and add more information in next version.
=20
Ran
> >
> > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/soc/fsl/rcpm.txt |   42 ++++++------=
-----
> --
> >  1 files changed, 13 insertions(+), 29 deletions(-)
