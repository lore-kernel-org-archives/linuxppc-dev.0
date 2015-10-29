Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0125.outbound.protection.outlook.com [65.55.169.125])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 30C9A1A0B51
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 02:24:54 +1100 (AEDT)
Message-ID: <1446132279.701.368.camel@freescale.com>
Subject: Re: [V5, 2/6] fsl/fman: Add FMan support
From: Scott Wood <scottwood@freescale.com>
To: Liberman Igal-B31950 <Igal.Liberman@freescale.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Bucur
 Madalin-Cristian-B32716" <madalin.bucur@freescale.com>
Date: Thu, 29 Oct 2015 10:24:39 -0500
In-Reply-To: <DM2PR03MB509C1B1A5272C9D0A9F8295E6200@DM2PR03MB509.namprd03.prod.outlook.com>
References: <1442836354-5445-1-git-send-email-igal.liberman@freescale.com>
 <20150925230153.GA4626@home.buserror.net>
 <BL2PR03MB5006080090B6783629A33A5E6220@BL2PR03MB500.namprd03.prod.outlook.com>
 <1446067854.701.365.camel@freescale.com>
 <DM2PR03MB509C1B1A5272C9D0A9F8295E6200@DM2PR03MB509.namprd03.prod.outlook.com>
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

On Thu, 2015-10-29 at 10:22 -0500, Liberman Igal-B31950 wrote:
> Regards,
> Igal Liberman
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Wednesday, October 28, 2015 11:31 PM
> > To: Liberman Igal-B31950 <Igal.Liberman@freescale.com>
> > Cc: netdev@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; linux-
> > kernel@vger.kernel.org; Bucur Madalin-Cristian-B32716
> > <madalin.bucur@freescale.com>
> > Subject: Re: [V5, 2/6] fsl/fman: Add FMan support
> > 
> > On Tue, 2015-10-27 at 11:32 -0500, Liberman Igal-B31950 wrote:
> > 
> > > > > +
> > > > > +struct device *fman_get_device(struct fman *fman) {  return
> > > > > +fman->dev; }
> > > > 
> > > > Is this really necessary?
> > > > 
> > > 
> > > Fman port needs fman->dev, fman structure is opaque, so yes, it's 
> > > needed.
> > 
> > Why is opacity being maintained from one part of the fman driver to
> > another?
> > Isn't this the sort of excessive layering that was complained about?
> > 
> > 
> 
> It's not really layering.
> Fman Port uses Fman resources, it's not completely standalone. 

That's my point -- if it's not standalone, why is "struct fman" opaque to the 
port code?

-Scott
