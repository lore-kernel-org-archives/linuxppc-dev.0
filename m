Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3AD0C2C0082
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2013 04:28:44 +1100 (EST)
Date: Wed, 23 Jan 2013 11:28:33 -0600
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] powerpc/mpic: allow coreint to be determined by
 MPIC version
To: Kumar Gala <galak@kernel.crashing.org>
References: <1358819804-28665-1-git-send-email-scottwood@freescale.com>
 <AAD002DB-C259-4054-A126-950B69BF1B5D@kernel.crashing.org>
In-Reply-To: <AAD002DB-C259-4054-A126-950B69BF1B5D@kernel.crashing.org>
 (from galak@kernel.crashing.org on Wed Jan 23 11:23:51 2013)
Message-ID: <1358962113.9710.2@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/23/2013 11:23:51 AM, Kumar Gala wrote:
>=20
> On Jan 21, 2013, at 7:56 PM, Scott Wood wrote:
>=20
> > This will be used by the qemu-e500 platform, as the MPIC version =20
> (and
> > thus whether we have coreint) depends on how QEMU is configured.
> >
> > Signed-off-by: Scott Wood <scottwood@freescale.com>
> > ---
> > arch/powerpc/sysdev/mpic.c |   26 +++++++++++++++++++++++---
> > 1 file changed, 23 insertions(+), 3 deletions(-)
>=20
> Is the idea that we'd set mpic->flags such that MPIC_ENABLE_COREINT =20
> was set, but based on the controller version we'd ignore the flag?

Yes, at least for platforms like qemu-e500 where both are posssible =20
(see patch 2/2).

-Scott=
