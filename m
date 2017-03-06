Return-Path: <srs0=1leb=2p=kernel.crashing.org=benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcYC63LyCzDqFh
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 08:41:38 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vcYC62lQmz8sX0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 08:41:38 +1100 (AEDT)
Message-ID: <1488836491.2870.140.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: sparsemem should be the default on powernv
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Date: Tue, 07 Mar 2017 08:41:31 +1100
In-Reply-To: <87fuiqpwrc.fsf@concordia.ellerman.id.au>
References: <1488754796.2870.112.camel@kernel.crashing.org>
 <87fuiqpwrc.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-03-06 at 20:41 +1100, Michael Ellerman wrote:
> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > index 4940917..c4b4c55 100644
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -580,7 +580,7 @@ config ARCH_SPARSEMEM_ENABLE
> >   
> >   config ARCH_SPARSEMEM_DEFAULT
> >        def_bool y
> > -     depends on (SMP && PPC_PSERIES) || PPC_PS3
> > +     depends on (SMP && PPC_PSERIES) || PPC_PS3 || PPC_POWERNV
> 
> Why don't we just make it default y for BOOK3S_64?
> 
> It's just the default after all, it can still be changed.

No objection.

Cheers,
Ben.
