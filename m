Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0183.outbound.protection.outlook.com [207.46.163.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DECD62C00BE
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Dec 2013 09:54:12 +1100 (EST)
Message-ID: <1388184839.21454.22.camel@snotra.buserror.net>
Subject: Re: [PATCH 4/5] powerpc/fsl-booke: Add initial T208x QDS board support
From: Scott Wood <scottwood@freescale.com>
To: Liu Shengzhou-B36685 <Shengzhou.Liu@freescale.com>
Date: Fri, 27 Dec 2013 16:53:59 -0600
In-Reply-To: <1baad106bec84b5a9f8f3298e1476330@DM2PR03MB398.namprd03.prod.outlook.com>
References: <1386760774-14743-1-git-send-email-Shengzhou.Liu@freescale.com>
 <1386760774-14743-4-git-send-email-Shengzhou.Liu@freescale.com>
 <1387310222.10013.439.camel@snotra.buserror.net>
 <1baad106bec84b5a9f8f3298e1476330@DM2PR03MB398.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 2013-12-20 at 00:42 -0600, Liu Shengzhou-B36685 wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Wednesday, December 18, 2013 3:57 AM
> > To: Liu Shengzhou-B36685
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [PATCH 4/5] powerpc/fsl-booke: Add initial T208x QDS board
> > support
> > 
> > On Wed, 2013-12-11 at 19:19 +0800, Shengzhou Liu wrote:
> > > +		boardctrl: board-control@3,0 {
> > > +			#address-cells = <1>;
> > > +			#size-cells = <1>;
> > > +			compatible = "fsl,fpga-qixis";
> > > +			reg = <3 0 0x300>;
> > > +			ranges = <0 3 0 0x300>;
> > > +		};
> > 
> > Why do you have ranges and #address-cells/#size-cells here?  When would
> > there ever be a child node?
> 
> [Shengzhou] There are multiple child nodes for this(in a separate DPAA-related patch, but whole DPAA module has not been upstreamed yet so far)

Those properties can be added if and when the dpaa nodes go upstream.
They don't make sense as is.

-Scott
