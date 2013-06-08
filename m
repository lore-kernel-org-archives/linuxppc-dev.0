Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0188.outbound.messaging.microsoft.com [213.199.154.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0006B2C02A1
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Jun 2013 10:00:16 +1000 (EST)
Date: Fri, 7 Jun 2013 19:00:04 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/3] powerpc/mpc85xx: remove the unneeded pci init
 functions for corenet ds board
To: Kevin Hao <haokexin@gmail.com>
In-Reply-To: <20130607020020.GA4678@pek-khao-d1.corp.ad.wrs.com> (from
 haokexin@gmail.com on Thu Jun  6 21:00:20 2013)
Message-ID: <1370649604.6813.21@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/06/2013 09:00:20 PM, Kevin Hao wrote:
> As you can see, the only difference between these two logs is the
> io resource address and all the mem and bus address are still the
> same.

Hmm... The thing that originally motivated the picking of an arbitrary =20
primary was virtio being assigned a BAR of zero, and QEMU not liking =20
that.  I guess something changed so that's no longer happening, even =20
without a primary.

> > Is anything actually fixed by this?
>=20
> No. As you know the reason we need a primary bus is that we need to =20
> support
> some ISA legacy devices. So it seems a little weird that we have to =20
> pick
> one primary bus even on a board which doesn't has ISA at all.

Yeah, it was a workaround for some other issues, as discussed.  It was =20
meant to be temporary.

-Scott=
