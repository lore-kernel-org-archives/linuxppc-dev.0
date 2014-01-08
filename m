Return-Path: <mark.rutland@arm.com>
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
 [217.140.96.50]) by ozlabs.org (Postfix) with ESMTP id C51E22C0086
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jan 2014 20:30:56 +1100 (EST)
Date: Wed, 8 Jan 2014 09:30:46 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Yuantian Tang <Yuantian.Tang@freescale.com>
Subject: Re: =?utf-8?B?562U5aSN?=
 =?utf-8?Q?=3A?= [v7] clk: corenet: Adds the clock binding
Message-ID: <20140108093046.GB6701@e106331-lin.cambridge.arm.com>
References: <1384938289-24713-1-git-send-email-Yuantian.Tang@freescale.com>
 <20140108002115.GA19801@home.buserror.net>
 <375c32b2f4e34589ae336af61468a51b@BL2PR03MB115.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <375c32b2f4e34589ae336af61468a51b@BL2PR03MB115.namprd03.prod.outlook.com>
Cc: Scott Wood <scottwood@freescale.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 08, 2014 at 08:53:56AM +0000, Yuantian Tang wrote:
> 
> ________________________________________
> 发件人: Wood Scott-B07421
> 发送时间: 2014年1月8日 8:21
> 收件人: Tang Yuantian-B29983
> 抄送: galak@kernel.crashing.org; mark.rutland@arm.com; devicetree@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> 主题: Re: [v7] clk: corenet: Adds the clock binding
> 
> On Wed, Nov 20, 2013 at 05:04:49PM +0800, tang yuantian wrote:
> > +Recommended properties:
> > +- ranges: Allows valid translation between child's address space and
> > +     parent's. Must be present if the device has sub-nodes.
> > +- #address-cells: Specifies the number of cells used to represent
> > +     physical base addresses.  Must be present if the device has
> > +     sub-nodes and set to 1 if present
> > +- #size-cells: Specifies the number of cells used to represent
> > +     the size of an address. Must be present if the device has
> > +     sub-nodes and set to 1 if present
> 
> Why are we specifying #address-cells/#size-cells here?
> 
> A: it has sub-nodes which have REG property, don't we need to 
> specify #address-cells/#size-cells?

If a node has a reg entry, its parent should have #size-cells and
#address-cells to allow it to be parsed properly.

Mark.
