Return-Path: <B40534@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A0D862C015A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2013 16:36:47 +1100 (EST)
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH] powerpc: add Book E support to 64-bit hibernation
Date: Wed, 3 Apr 2013 05:36:41 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F15439259EDC264@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1363949917.8238.25.camel@jlt4.sipsolutions.net>
 <1363990490.24790.12@snotra>
 <ABB05CD9C9F68C46A5CEDC7F15439259ED9C2E@039-SN2MPN1-021.039d.mgd.msft.net>
 <1364949294.24520.29@snotra>
In-Reply-To: <1364949294.24520.29@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Johannes Berg <johannes@sipsolutions.net>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Wednesday, April 03, 2013 8:35 AM
> To: Wang Dongsheng-B40534
> Cc: Wood Scott-B07421; Johannes Berg; linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH] powerpc: add Book E support to 64-bit hibernation
>=20
> On 04/02/2013 12:28:40 AM, Wang Dongsheng-B40534 wrote:
> > Hi scott & Johannes,
> >
> > Thanks for reviewing.
> >
> > @scott, About this patch, could you please help ack this patch?
>=20
> Please investigate the issue of whether we are loading kernel module
> code in this step, and whether cache flushing is needed as a result.
>=20
Sorry, I am not very clear what you mean.
When the kernel boot end, modprobe some xx.ko?

> Is there any chance we could even be loading user code here, e.g. if
> it's mlocked and thus couldn't be swapped out?
