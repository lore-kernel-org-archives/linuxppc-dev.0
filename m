Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0D37B2C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2013 03:37:51 +1100 (EST)
Date: Wed, 13 Mar 2013 11:37:39 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH V4] powerpc/85xx: Add machine check handler to fix PCIe
 erratum on mpc85xx
To: David Laight <David.Laight@ACULAB.COM>
References: <412C8208B4A0464FA894C5F0C278CD5D01C15369@039-SN1MPN1-003.039d.mgd.msft.net>
 <1363123452.17135.13@snotra>
 <AE90C24D6B3A694183C094C60CF0A2F6026B7186@saturn3.aculab.com>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B7186@saturn3.aculab.com>
 (from David.Laight@ACULAB.COM on Wed Mar 13 04:40:40 2013)
Message-ID: <1363192659.8945.1@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>, Stuart Yoder <b08248@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Jia Hongtao-B38951 <B38951@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/13/2013 04:40:40 AM, David Laight wrote:
> > Hmm, seems there's no probe_user_address() -- for userspace we
> > basically want the same thing minus the KERNEL_DS.  See
> > arch/powerpc/perf/callchain.c for an example.
>=20
> Isn't that just copy_from_user() ?

Plus pagefault_disable/enable().

-Scott=
