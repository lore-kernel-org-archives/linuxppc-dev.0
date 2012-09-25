Return-Path: <B07421@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe002.messaging.microsoft.com [213.199.154.140])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 12E5F2C008A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2012 10:51:02 +1000 (EST)
Date: Mon, 24 Sep 2012 19:50:51 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: Probing for native availability of isel from userspace
To: malc <av1474@comtv.ru>
References: <1348530909.25867.29@snotra> <1348533123.1132.102.camel@pasglop>
 <alpine.LNX.2.00.1209250446300.9670@linmac>
In-Reply-To: <alpine.LNX.2.00.1209250446300.9670@linmac> (from
 av1474@comtv.ru on Mon Sep 24 19:47:28 2012)
Message-ID: <1348534251.25867.34@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org, hollis@penguinppc.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/24/2012 07:47:28 PM, malc wrote:
> On Tue, 25 Sep 2012, Benjamin Herrenschmidt wrote:
>=20
> > On Mon, 2012-09-24 at 18:55 -0500, Scott Wood wrote:
> > > The ISA says that isel is "Category: Phased-In (sV2.06)" -- are =20
> there
> > > any 2.06 chips that don't have it?
> >
> > I believe "malc" is interested in knowing about pre-2.06 chips that =20
> have
> > it.
> >
>=20
> That too, but also what 's' prefix means.

I think it's trying to say that it's phased-in for server but mandatory =20
for embedded, though I don't see that exact notation used anywhere else =20
in the document.

-Scott=
