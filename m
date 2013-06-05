Return-Path: <B02008@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 931D82C0096
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jun 2013 17:10:42 +1000 (EST)
From: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [RFC PATCH 0/6] KVM: PPC: Book3E: AltiVec support
Date: Wed, 5 Jun 2013 07:10:07 +0000
Message-ID: <300B73AA675FCE4A93EB4FC1D42459FF44EB49@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1370292868-2697-1-git-send-email-mihai.caraman@freescale.com>
 (from mihai.caraman@freescale.com on Mon Jun  3 15:54:22 2013)
 <1370381959.748.16@snotra>
In-Reply-To: <1370381959.748.16@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 Alexander Graf <agraf@suse.de>
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
> Sent: Wednesday, June 05, 2013 12:39 AM
> To: Caraman Mihai Claudiu-B02008
> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org; Alexander Graf
> Subject: Re: [RFC PATCH 0/6] KVM: PPC: Book3E: AltiVec support
>=20
> On 06/03/2013 03:54:22 PM, Mihai Caraman wrote:
> > Mihai Caraman (6):
> >   KVM: PPC: Book3E: Fix AltiVec interrupt numbers and build breakage
> >   KVM: PPC: Book3E: Refactor SPE_FP exit handling
> >   KVM: PPC: Book3E: Rename IRQPRIO names to accommodate ALTIVEC
> >   KVM: PPC: Book3E: Add AltiVec support
> >   KVM: PPC: Book3E: Add ONE_REG AltiVec support
> >   KVM: PPC: Book3E: Enhance FPU laziness
> >
> >  arch/powerpc/include/asm/kvm_asm.h    |   16 ++-
> >  arch/powerpc/kvm/booke.c              |  189
> > ++++++++++++++++++++++++++++----
> >  arch/powerpc/kvm/booke.h              |    4 +-
> >  arch/powerpc/kvm/bookehv_interrupts.S |    8 +-
> >  arch/powerpc/kvm/e500.c               |   10 +-
> >  arch/powerpc/kvm/e500_emulate.c       |    8 +-
> >  arch/powerpc/kvm/e500mc.c             |   10 ++-
> >  7 files changed, 199 insertions(+), 46 deletions(-)
>=20
> This looks like a bit much for 3.10 (certainly, subject lines like
> "refactor" and "enhance" and "add support" aren't going to make Linus
> happy given that we're past rc4) so I think we should apply
> http://patchwork.ozlabs.org/patch/242896/ for 3.10.  Then for 3.11,
> revert it after applying this patchset.
>=20

Why not 1/6 plus e6500 removal?

-Mike
