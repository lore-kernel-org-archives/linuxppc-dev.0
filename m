Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 686B52C00F4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2013 07:15:54 +1100 (EST)
Date: Wed, 3 Apr 2013 15:15:40 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc: add Book E support to 64-bit hibernation
To: Wang Dongsheng-B40534 <B40534@freescale.com>
References: <1363949917.8238.25.camel@jlt4.sipsolutions.net>
 <1363990490.24790.12@snotra>
 <ABB05CD9C9F68C46A5CEDC7F15439259ED9C2E@039-SN2MPN1-021.039d.mgd.msft.net>
 <1364949294.24520.29@snotra>
 <ABB05CD9C9F68C46A5CEDC7F15439259EDC264@039-SN2MPN1-021.039d.mgd.msft.net>
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F15439259EDC264@039-SN2MPN1-021.039d.mgd.msft.net>
 (from B40534@freescale.com on Wed Apr  3 00:36:41 2013)
Message-ID: <1365020140.25627.9@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/03/2013 12:36:41 AM, Wang Dongsheng-B40534 wrote:
>=20
>=20
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Wednesday, April 03, 2013 8:35 AM
> > To: Wang Dongsheng-B40534
> > Cc: Wood Scott-B07421; Johannes Berg; linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [PATCH] powerpc: add Book E support to 64-bit =20
> hibernation
> >
> > On 04/02/2013 12:28:40 AM, Wang Dongsheng-B40534 wrote:
> > > Hi scott & Johannes,
> > >
> > > Thanks for reviewing.
> > >
> > > @scott, About this patch, could you please help ack this patch?
> >
> > Please investigate the issue of whether we are loading kernel module
> > code in this step, and whether cache flushing is needed as a result.
> >
> Sorry, I am not very clear what you mean.
> When the kernel boot end, modprobe some xx.ko?

Suppose, before the kernel was suspended, modules had been loaded.  At =20
what point do those modules get restored, and when does the cache get =20
flushed?

-Scott=
