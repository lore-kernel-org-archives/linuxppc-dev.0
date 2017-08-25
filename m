Return-Path: <madalin.bucur@nxp.com>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0062.outbound.protection.outlook.com [104.47.0.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdqyH1Y3QzDrS2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Aug 2017 15:50:29 +1000 (AEST)
From: Madalin-cristian Bucur <madalin.bucur@nxp.com>
To: David Miller <davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 0/7] Add RSS to DPAA 1.x Ethernet driver
Date: Fri, 25 Aug 2017 05:50:22 +0000
Message-ID: <AM5PR0402MB2691E45A664F38D0824658CCEC9B0@AM5PR0402MB2691.eurprd04.prod.outlook.com>
References: <1503559708-13405-1-git-send-email-madalin.bucur@nxp.com>
 <20170824.094220.1750290899777462105.davem@davemloft.net>
 <20170824.114741.1529064786944246878.davem@davemloft.net>
In-Reply-To: <20170824.114741.1529064786944246878.davem@davemloft.net>
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
> From: David Miller [mailto:davem@davemloft.net]
> Subject: Re: [PATCH v3 0/7] Add RSS to DPAA 1.x Ethernet driver
>=20
> From: David Miller <davem@davemloft.net>
> Date: Thu, 24 Aug 2017 09:42:20 -0700 (PDT)
>=20
> > From: Madalin Bucur <madalin.bucur@nxp.com>
> > Date: Thu, 24 Aug 2017 10:28:21 +0300
> >
> >> This patch set introduces Receive Side Scaling for the DPAA Ethernet
> >> driver. Documentation is updated with details related to the new
> >> feature and limitations that apply.
> >> Added also a small fix.
> >>
> >> v2: removed a C++ style comment
> >> v3: move struct fman to header file to avoid exporting a function
> >
> > Series applied, thanks.
>=20
> Actually I'm reverting, this doesn't even compile.

Hi,

Sorry for this blunder, I've only tested on PPC, where it works.
Will come back with a proper patch set.

Madalin
