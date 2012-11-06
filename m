Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3BC062C008C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Nov 2012 07:13:21 +1100 (EST)
Date: Tue, 6 Nov 2012 14:13:07 -0600
From: Scott Wood <scottwood@freescale.com>
Subject: Re: powerpc: Don't silently handle machine checks from userspace
To: Micha Nelissen <micha.nelissen@Prodrive.nl>
In-Reply-To: <39F93B8F6D09AC4DA45E2F19603FA69C324F2605@exc02.bk.prodrive.nl>
 (from micha.nelissen@Prodrive.nl on Tue Nov  6 10:43:19 2012)
Message-ID: <1352232787.21833.6@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Martijn de Gouw <martijn.de.gouw@Prodrive.nl>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/06/2012 10:43:19 AM, Micha Nelissen wrote:
> From: Scott Wood [mailto:scottwood@freescale.com]
> >> Hmm I guess there is no simple solution then, since the "recover"
> >> function also prints the kernel messages about the machine check
> >> being in kernel mode without having checked whether it really was =20
> in
> >> kernel mode. In the past the user mode check was in between.
> >
> > It shouldn't be that difficult to make it say "in user mode" or "in
> > kernel mode" depending on which it was... or just remove that phrase
> > altogether and let the following output indicate whether it was in
> > kernel mode.
>=20
> Well printing the correct message is only part of it: do "we" want to =20
> pass guarded load errors (RapidIO bus errors) to user space or not?

Yes.

> And if we pass them, should we print a kernel message at all?

Yes (but maybe ratelimited).

-Scott=
