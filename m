Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0205.outbound.protection.outlook.com [207.46.163.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 128841A0326
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 05:05:36 +1000 (EST)
Message-ID: <1403031915.6603.771.camel@snotra.buserror.net>
Subject: Re: [PATCH v2] KVM: PPC: e500mc: Enhance tlb invalidation condition
 on vcpu schedule
From: Scott Wood <scottwood@freescale.com>
To: Caraman Mihai Claudiu-B02008 <mihai.caraman@freescale.com>
Date: Tue, 17 Jun 2014 14:05:15 -0500
In-Reply-To: <66e18c10162144f0b9e63c6c3b0ade84@BY2PR03MB508.namprd03.prod.outlook.com>
References: <1402995739-23756-1-git-send-email-mihai.caraman@freescale.com>
 <1403019343.6603.723.camel@snotra.buserror.net>
 <66e18c10162144f0b9e63c6c3b0ade84@BY2PR03MB508.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 2014-06-17 at 14:04 -0500, Caraman Mihai Claudiu-B02008 wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Tuesday, June 17, 2014 6:36 PM
> > To: Caraman Mihai Claudiu-B02008
> > Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-
> > dev@lists.ozlabs.org
> > Subject: Re: [PATCH v2] KVM: PPC: e500mc: Enhance tlb invalidation
> > condition on vcpu schedule
> > 
> > On Tue, 2014-06-17 at 12:02 +0300, Mihai Caraman wrote:
> > > On vcpu schedule, the condition checked for tlb pollution is too loose.
> > > The tlb entries of a vcpu become polluted (vs stale) only when a
> > different
> > > vcpu within the same logical partition runs in-between. Optimize the
> > tlb
> > > invalidation condition taking into account the logical partition id.
> > >
> > > With the new invalidation condition, a guest shows 4% performance
> > improvement
> > > on P5020DS while running a memory stress application with the cpu
> > oversubscribed,
> > > the other guest running a cpu intensive workload.
> > 
> > See
> > https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-June/118547.html
> 
> Thanks. The original code needs just a simple adjustment to benefit from
> this optimization, please review v3.

Where is v3?  Or is it forthcoming?

-Scott
