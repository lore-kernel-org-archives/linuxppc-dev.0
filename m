Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0114.outbound.protection.outlook.com [157.56.111.114])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2BC2E1A0D77
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 03:03:09 +1000 (AEST)
Message-ID: <1428598976.22867.535.camel@freescale.com>
Subject: Re: [v2] dt/bindings: qoriq-clock: Add binding for FMan clock mux
From: Scott Wood <scottwood@freescale.com>
To: Liberman Igal-B31950 <Igal.Liberman@freescale.com>
Date: Thu, 9 Apr 2015 12:02:56 -0500
In-Reply-To: <DM2PR03MB383D9FD2888970950261FB2E6FB0@DM2PR03MB383.namprd03.prod.outlook.com>
References: <1428479031-26597-1-git-send-email-igal.liberman@freescale.com>
 <1428527516.22867.509.camel@freescale.com>
 <DM2PR03MB383D9FD2888970950261FB2E6FB0@DM2PR03MB383.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-04-09 at 02:18 -0500, Liberman Igal-B31950 wrote:
> 
> 
> Regards,
> Igal Liberman.
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Thursday, April 09, 2015 12:12 AM
> > To: Liberman Igal-B31950
> > Cc: devicetree@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [v2] dt/bindings: qoriq-clock: Add binding for FMan clock mux
> > 
> > On Wed, 2015-04-08 at 10:43 +0300, Igal.Liberman wrote:
> > > @@ -76,6 +77,52 @@ Required properties:
> > >
> > >  Recommended properties:
> > >  - clocks: Should be the phandle of input parent clock
> > > +	For "fsl,fman-clk-mux" clock there are several options for parent
> > > +	clock (clock provider), the parent is determined according to the
> > > +	Reset Configuration Word of the specific device:
> > > +		* P2041, P3041:
> > > +			* 0 - equal to platform PLL divided by 2
> > > +			* 1 - equal to PLL2 divided by 2
> > > +		* P4080 (Both FMans):
> > > +			* 0 - equal to platform PLL divided by 2
> > > +			* 1 - equal to PLL3 divided by 2
> > ...
> > 
> > 
> > Again, the clock specifier format is determined by the clock provider, not the
> > clock consumer.
> > 
> 
> Scott,
> The "clocks" property contains all possible clock providers, right?
> In the text above I'm trying to explain how the FMan clock provider is determined and what are the options for each SoC.
> Do you think that we shouldn't have this explanation? Can you please elaborate?

I'm saying that the clock specifiers must be the same regardless of the
node that is consuming the clock.  You can't define certain values as
only being "for fsl,fman-clk-mux".

-Scott
