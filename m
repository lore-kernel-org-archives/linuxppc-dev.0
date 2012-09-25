Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 19CA12C008E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2012 10:41:00 +1000 (EST)
Date: Mon, 24 Sep 2012 19:40:46 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: Probing for native availability of isel from userspace
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1348530909.25867.29@snotra> <1348533123.1132.102.camel@pasglop>
In-Reply-To: <1348533123.1132.102.camel@pasglop> (from
 benh@kernel.crashing.org on Mon Sep 24 19:32:03 2012)
Message-ID: <1348533646.25867.33@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: malc <av1474@comtv.ru>, linuxppc-dev@lists.ozlabs.org,
 hollis@penguinppc.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/24/2012 07:32:03 PM, Benjamin Herrenschmidt wrote:
> On Mon, 2012-09-24 at 18:55 -0500, Scott Wood wrote:
> > The ISA says that isel is "Category: Phased-In (sV2.06)" -- are =20
> there
> > any 2.06 chips that don't have it?
>=20
> I believe "malc" is interested in knowing about pre-2.06 chips that =20
> have
> it.

You said to key off of 2.06 plus a PVR whitelist for pre-2.06 chips =20
that have it.  Wouldn't you also need a PVR blacklist for 2.06 chips =20
that don't have it (unless there are no such things)?  Or if one is =20
only interested in pre-2.06 chips, why check for 2.06 at all?

-Scott=
