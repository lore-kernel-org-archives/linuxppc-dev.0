Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0120.outbound.protection.outlook.com [65.55.169.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2C3D61A0145
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 12:44:07 +1000 (AEST)
Message-ID: <1443149032.32298.102.camel@freescale.com>
Subject: Re: [PATCH v3 1/2] fsl: Add binding for RCPM
From: Scott Wood <scottwood@freescale.com>
To: Wang Dongsheng-B40534 <Dongsheng.Wang@freescale.com>
CC: "robh+dt@kernel.org" <robh+dt@kernel.org>, "shawnguo@kernel.org"
 <shawnguo@kernel.org>, Jin Zhengxiong-R64188 <Jason.Jin@freescale.com>, "Wang
 Huan-B18965" <alison.wang@freescale.com>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Zhao Chenhui-B35336
 <chenhui.zhao@freescale.com>, Tang Yuantian-B29983
 <Yuantian.Tang@freescale.com>
Date: Thu, 24 Sep 2015 21:43:52 -0500
In-Reply-To: <SN1PR0301MB161653CC69BB78A0A8B565569D420@SN1PR0301MB1616.namprd03.prod.outlook.com>
References: <1443083354-37369-1-git-send-email-dongsheng.wang@freescale.com>
 <1443123009.32298.29.camel@freescale.com>
 <SN1PR0301MB161653CC69BB78A0A8B565569D420@SN1PR0301MB1616.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-09-24 at 21:38 -0500, Wang Dongsheng-B40534 wrote:
> > > +* Freescale RCPM Wakeup Source Device Tree Bindings
> > > +-------------------------------------------
> > > +Required rcpm-wakeup property should be added to a device node if the
> > > device
> > > +can be used as a wakeup source.
> > > +
> > > +  - rcpm-wakeup: The value of the property consists of cells, the 
> > > number of
> > > +     cells defined in "fsl,#rcpm-wakeup-cells". The first cell is a 
> > > pointer
> > > +     to the rcpm node, the second cell is the bit mask that should be 
> > > set
> > > +     in IPPDEXPCR0, and the third cell is for IPPDEXPCR1, and so on.
> > 
> > The phandle should not be included in the cell count.
> > 
> 
> Yes, the first cell "&rcpm" should be in the cell count, right?

No.  None of the other #foo-cells work that way.

-Scott
