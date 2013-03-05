Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 78D652C0325
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2013 07:47:38 +1100 (EST)
Date: Tue, 5 Mar 2013 14:47:29 -0600
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH][v2] powerpc/e6500: Add Power ISA properties for e6500
 cores
To: Yoder Stuart-B08248 <B08248@freescale.com>
References: <1362514602-17920-1-git-send-email-stuart.yoder@freescale.com>
 <1362515356.25308.8@snotra>
 <9F6FE96B71CF29479FF1CDC8046E1503567049@039-SN1MPN1-003.039d.mgd.msft.net>
In-Reply-To: <9F6FE96B71CF29479FF1CDC8046E1503567049@039-SN1MPN1-003.039d.mgd.msft.net>
 (from B08248@freescale.com on Tue Mar  5 14:37:42 2013)
Message-ID: <1362516449.25308.10@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/05/2013 02:37:42 PM, Yoder Stuart-B08248 wrote:
>=20
>=20
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Tuesday, March 05, 2013 2:29 PM
> > To: Yoder Stuart-B08248
> > Cc: galak@kernel.crashing.org; linuxppc-dev@lists.ozlabs.org; Yoder =20
> Stuart-B08248
> > Subject: Re: [PATCH][v2] powerpc/e6500: Add Power ISA properties =20
> for e6500 cores
> >
> > ER and DEO are FSL EREF categories, not Power ISA categories.
>=20
> Ok, so not Power ISA strictly speaking, but are architectural
> categories.  So should we invent a new convention of fsl-eref-*??

Sure, or "fsl,eref-*".

-Scott=
