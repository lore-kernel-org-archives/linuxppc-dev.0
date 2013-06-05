Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe006.messaging.microsoft.com [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 40ADF2C009F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jun 2013 02:35:15 +1000 (EST)
Date: Wed, 5 Jun 2013 11:35:03 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC PATCH 0/6] KVM: PPC: Book3E: AltiVec support
To: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
References: <1370292868-2697-1-git-send-email-mihai.caraman@freescale.com>
 <1370381959.748.16@snotra>
 <300B73AA675FCE4A93EB4FC1D42459FF44EB49@039-SN2MPN1-011.039d.mgd.msft.net>
In-Reply-To: <300B73AA675FCE4A93EB4FC1D42459FF44EB49@039-SN2MPN1-011.039d.mgd.msft.net>
 (from B02008@freescale.com on Wed Jun  5 02:10:07 2013)
Message-ID: <1370450103.26139.0@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
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

On 06/05/2013 02:10:07 AM, Caraman Mihai Claudiu-B02008 wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Wednesday, June 05, 2013 12:39 AM
> > To: Caraman Mihai Claudiu-B02008
> > Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-
> > dev@lists.ozlabs.org; Alexander Graf
> > Subject: Re: [RFC PATCH 0/6] KVM: PPC: Book3E: AltiVec support
> >
> > On 06/03/2013 03:54:22 PM, Mihai Caraman wrote:
> > > Mihai Caraman (6):
> > >   KVM: PPC: Book3E: Fix AltiVec interrupt numbers and build =20
> breakage
> > >   KVM: PPC: Book3E: Refactor SPE_FP exit handling
> > >   KVM: PPC: Book3E: Rename IRQPRIO names to accommodate ALTIVEC
> > >   KVM: PPC: Book3E: Add AltiVec support
> > >   KVM: PPC: Book3E: Add ONE_REG AltiVec support
> > >   KVM: PPC: Book3E: Enhance FPU laziness
> > >
> > >  arch/powerpc/include/asm/kvm_asm.h    |   16 ++-
> > >  arch/powerpc/kvm/booke.c              |  189
> > > ++++++++++++++++++++++++++++----
> > >  arch/powerpc/kvm/booke.h              |    4 +-
> > >  arch/powerpc/kvm/bookehv_interrupts.S |    8 +-
> > >  arch/powerpc/kvm/e500.c               |   10 +-
> > >  arch/powerpc/kvm/e500_emulate.c       |    8 +-
> > >  arch/powerpc/kvm/e500mc.c             |   10 ++-
> > >  7 files changed, 199 insertions(+), 46 deletions(-)
> >
> > This looks like a bit much for 3.10 (certainly, subject lines like
> > "refactor" and "enhance" and "add support" aren't going to make =20
> Linus
> > happy given that we're past rc4) so I think we should apply
> > http://patchwork.ozlabs.org/patch/242896/ for 3.10.  Then for 3.11,
> > revert it after applying this patchset.
> >
>=20
> Why not 1/6 plus e6500 removal?

1/6 is not a bugfix.

-Scott=
