Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0140.outbound.protection.outlook.com [65.55.169.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E4DAD1A0047
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2015 08:01:18 +1000 (AEST)
Message-ID: <1433196052.4089.184.camel@freescale.com>
Subject: Re: [2/4,v3] powerpc/fsl-booke: Add T1024 QDS board support
From: Scott Wood <scottwood@freescale.com>
To: Liu Shengzhou-B36685 <Shengzhou.Liu@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 1 Jun 2015 17:00:52 -0500
In-Reply-To: <DM2PR03MB398E053EB9A4BE50EE67B7FF8B60@DM2PR03MB398.namprd03.prod.outlook.com>
References: <1428566865-35732-2-git-send-email-Shengzhou.Liu@freescale.com>
 <20150529002436.GA4248@home.buserror.net>
 <DM2PR03MB398E053EB9A4BE50EE67B7FF8B60@DM2PR03MB398.namprd03.prod.outlook.com>
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

On Mon, 2015-06-01 at 03:23 -0500, Liu Shengzhou-B36685 wrote:
> > Subject: Re: [2/4,v3] powerpc/fsl-booke: Add T1024 QDS board 
> > support
> > 
> > On Thu, Apr 09, 2015 at 04:07:43PM +0800, Shengzhou Liu wrote:
> > > +                  flash@2{
> > > +                         #address-cells = <1>;
> > > +                         #size-cells = <1>;
> > > +                         compatible = "eon,en25s64";   /* 8MB */
> > > +                         reg = <2>;
> > > +                         spi-max-frequency = <10000000>;
> > > +                 };
> > 
> > AFAICT the vendor is phyton, not eon.
> 
> How do you think the vendor is phyton?
> Per en25s64 data sheet, it's really EON (Eon Silicon Solution, Inc,  
> www.eonssi.com)

I'm not sure.  The search results for it look a bit different from 
what I remember seeing last week.  I'll fix it.

> I had sent a patch for EON  http://patchwork.ozlabs.org/patch/367810/
> last year.
> There is no 'phyton' in binding document. 

There is no binding document.  As for vendor-prefixes, you should ping 
to get that patch merged -- and when you're depending on an unmerged 
patch (even if just documentation), please mention it below the --- 
line when submitting.

-Scott
