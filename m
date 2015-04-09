Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0135.outbound.protection.outlook.com [157.56.111.135])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 624951A0C73
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 09:54:28 +1000 (AEST)
Message-ID: <1428623653.22867.562.camel@freescale.com>
Subject: Re: [PATCH] dt/bindings: qoriq-clock: Add binding for FMan clock mux
From: Scott Wood <scottwood@freescale.com>
To: Liberman Igal-B31950 <Igal.Liberman@freescale.com>
Date: Thu, 9 Apr 2015 18:54:13 -0500
In-Reply-To: <DM2PR03MB383BB3A8993435B4F7D2EFDE6FC0@DM2PR03MB383.namprd03.prod.outlook.com>
References: <1428379720-3247-1-git-send-email-igal.liberman@freescale.com>
 <1428446404.22867.479.camel@freescale.com>
 <DM2PR03MB383BB3A8993435B4F7D2EFDE6FC0@DM2PR03MB383.namprd03.prod.outlook.com>
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

On Wed, 2015-04-08 at 03:54 -0500, Liberman Igal-B31950 wrote:
> Hi Scott
> 
> Regards,
> Igal Liberman.
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Wednesday, April 08, 2015 1:40 AM
> > To: Liberman Igal-B31950
> > Cc: devicetree@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [PATCH] dt/bindings: qoriq-clock: Add binding for FMan clock
> > mux
> > 
> > On Tue, 2015-04-07 at 07:08 +0300, Igal.Liberman wrote:
> > > From: Igal Liberman <Igal.Liberman@freescale.com>
> > >
> > > Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
> > > ---
> > >  .../devicetree/bindings/clock/qoriq-clock.txt      |   59
> > ++++++++++++++++++++
> > >  1 file changed, 59 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/clock/qoriq-clock.txt
> > > b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
> > > index df4a259..a7e84ce 100644
> > > --- a/Documentation/devicetree/bindings/clock/qoriq-clock.txt
> > > +++ b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
> > > @@ -65,6 +65,7 @@ Required properties:
> > >  		It takes parent's clock-frequency as its clock.
> > >  	* "fsl,qoriq-platform-pll-1.0" for the platform PLL clock (v1.0)
> > >  	* "fsl,qoriq-platform-pll-2.0" for the platform PLL clock (v2.0)
> > > +	* "fsl,fman-clk-mux" for the Frame Manager clock.
> > 
> > Is there any versioning required on this?
> > 
> 
> I don't think we need versioning here.

Even though we needed it on the other nodes?

-Scott
