Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0144.outbound.protection.outlook.com [207.46.100.144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 414B91A035C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 12:38:09 +1000 (AEST)
Message-ID: <1442371076.2909.171.camel@freescale.com>
Subject: Re: [PATCH v2 1/2] fsl: Add binding for RCPM
From: Scott Wood <scottwood@freescale.com>
To: Tang Yuantian-B29983 <Yuantian.Tang@freescale.com>
CC: Wang Dongsheng-B40534 <Dongsheng.Wang@freescale.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Wang Huan-B18965
 <alison.wang@freescale.com>, Jin Zhengxiong-R64188 <Jason.Jin@freescale.com>,
 Zhao Chenhui-B35336 <chenhui.zhao@freescale.com>
Date: Tue, 15 Sep 2015 21:37:56 -0500
In-Reply-To: <DM2PR03MB574196E1A0D55C185CE1B4BFA5B0@DM2PR03MB574.namprd03.prod.outlook.com>
References: <1442307339-15225-1-git-send-email-dongsheng.wang@freescale.com>
 <1442361398.2909.164.camel@freescale.com>
 <SN1PR0301MB1616C48FB3D990BCA45289AB9D5B0@SN1PR0301MB1616.namprd03.prod.outlook.com>
 <1442369955.2909.166.camel@freescale.com>
 <SN1PR0301MB161688E3AF527ADC76AB2B8F9D5B0@SN1PR0301MB1616.namprd03.prod.outlook.com>
 <1442370701.2909.167.camel@freescale.com>
 <DM2PR03MB574196E1A0D55C185CE1B4BFA5B0@DM2PR03MB574.namprd03.prod.outlook.com>
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

On Tue, 2015-09-15 at 21:35 -0500, Tang Yuantian-B29983 wrote:
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Wednesday, September 16, 2015 10:32 AM
> > To: Wang Dongsheng-B40534 <Dongsheng.Wang@freescale.com>
> > Cc: devicetree@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> > robh+dt@kernel.org; linux-arm-kernel@lists.infradead.org; Wang Huan-
> > B18965 <alison.wang@freescale.com>; Jin Zhengxiong-R64188
> > <Jason.Jin@freescale.com>; Zhao Chenhui-B35336
> > <chenhui.zhao@freescale.com>; Tang Yuantian-B29983
> > <Yuantian.Tang@freescale.com>
> > Subject: Re: [PATCH v2 1/2] fsl: Add binding for RCPM
> > 
> > On Tue, 2015-09-15 at 21:30 -0500, Wang Dongsheng-B40534 wrote:
> > > Hi Scott,
> > > 
> > > > -----Original Message-----
> > > > From: Wood Scott-B07421
> > > > Sent: Wednesday, September 16, 2015 10:19 AM
> > > > To: Wang Dongsheng-B40534
> > > > Cc: devicetree@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> > > > robh+dt@kernel.org; linux-arm-kernel@lists.infradead.org; Wang Huan-
> > > > B18965; Jin
> > > > Zhengxiong-R64188; Zhao Chenhui-B35336; Tang Yuantian-B29983
> > > > Subject: Re: [PATCH v2 1/2] fsl: Add binding for RCPM
> > > > 
> > > > On Tue, 2015-09-15 at 21:15 -0500, Wang Dongsheng-B40534 wrote:
> > > > > Hi Scott,
> > > > > 
> > > > > > -----Original Message-----
> > > > > > From: Wood Scott-B07421
> > > > > > Sent: Wednesday, September 16, 2015 7:57 AM
> > > > > > To: Wang Dongsheng-B40534
> > > > > > Cc: devicetree@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> > > > > > robh+dt@kernel.org; linux-arm-kernel@lists.infradead.org; Wang
> > > > > > robh+Huan-
> > > > > > B18965; Jin
> > > > > > Zhengxiong-R64188; Zhao Chenhui-B35336; Tang Yuantian-B29983
> > > > > > Subject: Re: [PATCH v2 1/2] fsl: Add binding for RCPM
> > > > > > 
> > > > > > On Tue, 2015-09-15 at 16:55 +0800, Dongsheng Wang wrote:
> > > > > > > +* Freescale RCPM Wakeup Source Device Tree Bindings
> > > > > > > +-------------------------------------------
> > > > > > > +Required rcpm-wakeup property should be added to a device
> > > > > > > +node if the
> > > > > > > device
> > > > > > > +can be used as a wakeup source.
> > > > > > > +
> > > > > > > +  - rcpm-wakeup: The value of the property consists of 3 cells.
> > > > > > > + The
> > > > > > > first
> > > > > > > cell
> > > > > > > +     is a pointer to the rcpm node, the second cell is the
> > > > > > > + bit mask
> > > > > > > that
> > > > > > > +     should be set in IPPDEXPCR0, and the last cell is for
> > > > > > > IPPDEXPCR1.
> > > > > > > +     Note: If the platform has no IPPDEXPCR1 register, put a
> > > > > > > + zero
> > > > > > > here.
> > > > > > 
> > > > > > What if a future platform has more than two of these registers?
> > > > > 
> > > > > Those registers are only used for wakeup device, we have a lot of
> > > > > available bit for feature. For example, In LS1021a platform only
> > > > > 7bits has used in the registers, and 57bits is reserved.
> > > > 
> > > > Still, it'd be better to for the rcpm node to advertise the number
> > > > of cells it expects.
> > > 
> > > For the foreseeable future it should be enough to use, even if not
> > > enough to use in the future at that time we can update the binding.
> > 
> > That's the whole point.  Device tree is stable ABI.  Updating it later to 
> > not be
> > fixed to two cells would be a lot harder than getting it right from the
> > beginning.  Putting the number of cells in the phandle target is a 
> > standard
> > device tree idiom.
> > 
> I agree with you. But what's the point a SOC has more than 64 wakeup source?

I don't know.  Hardware people do strange things sometimes.  They might not 
want to reuse bits they once used for something on some other chip, or they 
might have some encoding scheme in mind that results in the bits not being 
packed as tightly as possible, or there may be some big array of similar 
devices...

What's the point of skipping this part of the phandle-plus-arguments idiom?

-Scott
