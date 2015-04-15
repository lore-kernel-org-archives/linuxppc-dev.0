Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0112.outbound.protection.outlook.com [157.56.110.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 58D611A0143
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2015 03:16:39 +1000 (AEST)
Message-ID: <1429118180.22867.720.camel@freescale.com>
Subject: Re: [v2] dt/bindings: fsl/guts: Added global-utilities compatibles
From: Scott Wood <scottwood@freescale.com>
To: Liberman Igal-B31950 <Igal.Liberman@freescale.com>
Date: Wed, 15 Apr 2015 12:16:20 -0500
In-Reply-To: <DM2PR03MB3837B6B30125C77F1C6F89EE6E50@DM2PR03MB383.namprd03.prod.outlook.com>
References: <1429006329-24597-1-git-send-email-igal.liberman@freescale.com>
 <1429042131.22867.682.camel@freescale.com>
 <DM2PR03MB3837B6B30125C77F1C6F89EE6E50@DM2PR03MB383.namprd03.prod.outlook.com>
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

On Wed, 2015-04-15 at 03:43 -0500, Liberman Igal-B31950 wrote:
> 
> 
> Regards,
> Igal Liberman.
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Tuesday, April 14, 2015 11:09 PM
> > To: Liberman Igal-B31950
> > Cc: devicetree@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [v2] dt/bindings: fsl/guts: Added global-utilities compatibles
> > 
> > On Tue, 2015-04-14 at 13:12 +0300, Igal.Liberman wrote:
> > > From: Igal Liberman <Igal.Liberman@freescale.com>
> > >
> > > v2 - Addressed Scott's feedback
> > >
> > > Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
> > > ---
> > >  .../devicetree/bindings/powerpc/fsl/guts.txt       |    4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/powerpc/fsl/guts.txt
> > b/Documentation/devicetree/bindings/powerpc/fsl/guts.txt
> > > index 7f150b5..69644e6 100644
> > > --- a/Documentation/devicetree/bindings/powerpc/fsl/guts.txt
> > > +++ b/Documentation/devicetree/bindings/powerpc/fsl/guts.txt
> > > @@ -9,6 +9,10 @@ Required properties:
> > >
> > >   - compatible : Should define the compatible device type for
> > >     global-utilities.
> > > +   Possible compatibles:
> > > +	"fsl,qoriq-device-config-1.0"
> > > +	"fsl,qoriq-device-config-2.0"
> > > +	"fsl,<chip>-device-config"
> > 
> > fsl,<chip>-guts is also possible on non-corenet chips.
> > 
> 
> I added compatibles which are used for FMan Clock only.
> Do you want to add other compatibles too? Which? Or just mention that the 3 compatibles I've added doesn't cover all available options?

You're changing the binding from one that doesn't list compatibles to
one that does -- so please get all of them.

-Scott
