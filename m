Return-Path: <B02008@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0184.outbound.messaging.microsoft.com [213.199.154.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 324892C00B3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 16:48:07 +1000 (EST)
From: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: RE: [PATCH 2/2] KVM: PPC: Book3E: Add LRAT error exception handler
Date: Thu, 4 Jul 2013 06:47:56 +0000
Message-ID: <300B73AA675FCE4A93EB4FC1D42459FF0A2A4A86@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1372870566-11299-1-git-send-email-mihai.caraman@freescale.com>
 <1372870566-11299-2-git-send-email-mihai.caraman@freescale.com>
 <1372882590.8183.149@snotra>
In-Reply-To: <1372882590.8183.149@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
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
> Sent: Wednesday, July 03, 2013 11:17 PM
> To: Caraman Mihai Claudiu-B02008
> Cc: linuxppc-dev@lists.ozlabs.org; kvm-ppc@vger.kernel.org;
> kvm@vger.kernel.org; Caraman Mihai Claudiu-B02008
> Subject: Re: [PATCH 2/2] KVM: PPC: Book3E: Add LRAT error exception
> handler
>=20
> On 07/03/2013 11:56:06 AM, Mihai Caraman wrote:
> > With LRAT (Logical to Real Address Translation) error exception
> > handler in kernel
> > KVM needs to add the counterpart otherwise will break the build.
> >
> > Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> > ---
> >  arch/powerpc/kvm/bookehv_interrupts.S |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> Please combine these two patches to avoid breaking bisectability.
>=20
> -Scott

This is a solid reason. Ben it's ok for you to apply the combined patch?
If so I will respin it.

-Mike
