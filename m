Return-Path: <Igal.Liberman@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0134.outbound.protection.outlook.com [65.55.169.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DF0201A0073
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 22:48:17 +1000 (AEST)
From: Liberman Igal <Igal.Liberman@freescale.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Scott Wood
 <scottwood@freescale.com>, Madalin-Cristian Bucur
 <madalin.bucur@freescale.com>, "pebolle@tiscali.nl" <pebolle@tiscali.nl>,
 "joakim.tjernlund@transmode.se" <joakim.tjernlund@transmode.se>,
 "ppc@mindchasers.com" <ppc@mindchasers.com>
Subject: RE: [v3, 2/9] fsl/fman: Add the FMan port FLIB
Date: Thu, 23 Jul 2015 12:48:10 +0000
Message-ID: <DM2PR03MB383B0007660E892B81B5ADAE6820@DM2PR03MB383.namprd03.prod.outlook.com>
References: <1437564108-16490-1-git-send-email-igal.liberman@freescale.com>
 <20150722095553.4cd028d1@urahara>
In-Reply-To: <20150722095553.4cd028d1@urahara>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Regards,
Igal Liberman.

> -----Original Message-----
> From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> Sent: Wednesday, July 22, 2015 7:56 PM
> To: Liberman Igal-B31950
> Cc: netdev@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; linux-
> kernel@vger.kernel.org; Wood Scott-B07421; Bucur Madalin-Cristian-B32716;
> pebolle@tiscali.nl; joakim.tjernlund@transmode.se; ppc@mindchasers.com
> Subject: Re: [v3, 2/9] fsl/fman: Add the FMan port FLIB
>=20
> On Wed, 22 Jul 2015 14:21:48 +0300
> <igal.liberman@freescale.com> wrote:
>=20
> > diff --git a/drivers/net/ethernet/freescale/fman/Kconfig
> b/drivers/net/ethernet/freescale/fman/Kconfig
> > index 8aeae29..af42c3a 100644
> > --- a/drivers/net/ethernet/freescale/fman/Kconfig
> > +++ b/drivers/net/ethernet/freescale/fman/Kconfig
> > @@ -5,3 +5,4 @@ config FSL_FMAN
> >  	help
> >  		Freescale Data-Path Acceleration Architecture Frame
> Manager
> >  		(FMan) support
> > +
>=20
> Bogus blank line introduced at end of file?
> Why was this not in patch 1?

It was added during the patch splitting.
I'll fix that in the next submission, thank you for noticing.

Igal.
