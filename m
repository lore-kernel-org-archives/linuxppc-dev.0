Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0242.outbound.protection.outlook.com [207.46.163.242])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DC4941A00C1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jul 2014 11:46:55 +1000 (EST)
Message-ID: <1404870402.21434.286.camel@snotra.buserror.net>
Subject: Re: [PATCH] devicetree/bindings/powerpc/fsl: Add binding for board
From: Scott Wood <scottwood@freescale.com>
To: Jain Priyanka-B32167 <Priyanka.Jain@freescale.com>
Date: Tue, 8 Jul 2014 20:46:42 -0500
In-Reply-To: <5e950276b79a48e5bc3b65007f7fc208@BLUPR03MB135.namprd03.prod.outlook.com>
References: <1404722194-8103-1-git-send-email-Priyanka.Jain@freescale.com>
 <1404768624.21434.196.camel@snotra.buserror.net>
 <5e950276b79a48e5bc3b65007f7fc208@BLUPR03MB135.namprd03.prod.outlook.com>
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

On Mon, 2014-07-07 at 22:56 -0500, Jain Priyanka-B32167 wrote:
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Tuesday, July 08, 2014 3:00 AM
> > To: Jain Priyanka-B32167
> > Cc: devicetree@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [PATCH] devicetree/bindings/powerpc/fsl: Add binding for
> > board
> > 
> > On Mon, 2014-07-07 at 14:06 +0530, Priyanka Jain wrote:
> > > Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
> > > ---
> > >  .../devicetree/bindings/powerpc/fsl/board.txt      |   17
> > ++++++++++++++++-
> > >  1 files changed, 16 insertions(+), 1 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/powerpc/fsl/board.txt
> > > b/Documentation/devicetree/bindings/powerpc/fsl/board.txt
> > > index f35f295..7800729 100644
> > > --- a/Documentation/devicetree/bindings/powerpc/fsl/board.txt
> > > +++ b/Documentation/devicetree/bindings/powerpc/fsl/board.txt
> > > @@ -1,8 +1,23 @@
> > >  Freescale Reference Board Bindings
> > >
> > > -This document describes device tree bindings for various devices that
> > > +This document describes device tree bindings for board and  various
> > > +devices that
> > >  exist on some Freescale reference boards.
> > >
> > > +* Board node
> > > +Required properties:
> > > +
> > > + - model : Should be "fsl,<board>"
> > > + - compatible : Should be "fsl,<board>"
> > > +	example: "fsl,T1040RDB", "fsl,T1042RDB", "fsl,T1042RDB_PI"
> > > +		 "fsl,T1040QDS", "fsl,T1042QDS"
> > > +
> > > +Example:
> > > +
> > > +/ {
> > > +	model = "fsl,T1040RDB";
> > > +	compatible = "fsl,T1040RDB";
> > > +};
> > 
> > We really don't need to do this for every board just to satisfy
> > checkpatch.
> > 
> > -Scott
> > 
> [Jain Priyanka-B32167] Is it OK to submit a patch with board checkpatch warning for this case ?

If you mean "is it OK to submit a board patch that has checkpatch
warnings of this sort, where the compatible follows a well established
pattern", then yes.

-Scott
