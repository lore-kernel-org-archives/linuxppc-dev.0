Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0145.outbound.protection.outlook.com [157.56.110.145])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8B1DD1A0CE1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 13:43:54 +1100 (AEDT)
Message-ID: <1422585820.10544.146.camel@freescale.com>
Subject: Re: [PATCH][v4] power/fsl: add MDIO dt binding for FMan
From: Scott Wood <scottwood@freescale.com>
To: Xie Shaohui-B21989 <Shaohui.Xie@freescale.com>
Date: Thu, 29 Jan 2015 20:43:40 -0600
In-Reply-To: <DM2PR0301MB0864EF866EFDEB634BED54E5E2310@DM2PR0301MB0864.namprd03.prod.outlook.com>
References: <1422446064-3901-1-git-send-email-shh.xie@gmail.com>
 <1422579249.10544.140.camel@freescale.com>
 <DM2PR0301MB0864EF866EFDEB634BED54E5E2310@DM2PR0301MB0864.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Medve
 Emilian-EMMEDVE1 <Emilian.Medve@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-01-29 at 20:38 -0600, Xie Shaohui-B21989 wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Friday, January 30, 2015 8:54 AM
> > To: shh.xie@gmail.com
> > Cc: linuxppc-dev@lists.ozlabs.org; devicetree@vger.kernel.org; Medve
> > Emilian-EMMEDVE1; Xie Shaohui-B21989
> > Subject: Re: [PATCH][v4] power/fsl: add MDIO dt binding for FMan
> > 
> > On Wed, 2015-01-28 at 19:54 +0800, shh.xie@gmail.com wrote:
> > > +- interrupts
> > > +		Usage: required
> > > +		Value type: <prop-encoded-array>
> > > +		Definition: Event interrupt of external MDIO controller.
> > 
> > What if this MDIO controller is not "external"?  Should Usage say
> > "required for external MDIO"?
> [S.H] I thought the definition can tell the interrupt is for external MDIO,
> I can change the Usage to "required for external MDIO" in next version. 
> how about other parts, are they OK?

Yes.  I'll fix it up when applying.

-Scott
