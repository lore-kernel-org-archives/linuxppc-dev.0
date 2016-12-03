Return-Path: <alistair@popple.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tVrwR5zGXzDw40
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Dec 2016 11:08:55 +1100 (AEDT)
Received: from ipmail07.adl2.internode.on.net (ipmail07.adl2.internode.on.net
 [150.101.137.131])
 by ozlabs.org (Postfix) with ESMTP id 3tVrwR4FD4z9t1H
 for <linuxppc-dev@ozlabs.org>; Sat,  3 Dec 2016 11:08:55 +1100 (AEDT)
From: Alistair Popple <alistair@popple.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, bsingharora@gmail.com
Subject: Re: [PATCH v2] powerpc/powernv: Initialise nest mmu
Date: Sat, 03 Dec 2016 11:08:51 +1100
Message-ID: <1581241.5C7qS6j5fY@new-mexico>
In-Reply-To: <871sxqznt2.fsf@concordia.ellerman.id.au>
References: <1480656588-25504-1-git-send-email-alistair@popple.id.au>
 <871sxqznt2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2 Dec 2016 08:24:09 PM Michael Ellerman wrote:
> Alistair Popple <alistair@popple.id.au> writes:
> 
> > diff --git a/arch/powerpc/platforms/powernv/powernv.h b/arch/powerpc/platforms/powernv/powernv.h
> > index da7c843..6fa9551 100644
> > --- a/arch/powerpc/platforms/powernv/powernv.h
> > +++ b/arch/powerpc/platforms/powernv/powernv.h
> > @@ -9,6 +9,12 @@ static inline void pnv_smp_init(void) { }
> >  
> >  struct pci_dev;
> >  
> > +#ifdef CONFIG_PPC_POWERNV
> > +extern void powernv_set_ptcr(unsigned long ptcr);
> > +#else
> > +static inline void powernv_set_ptcr(unisigned long ptcr) { }
>                                          ^
>                                          Your shout next time we're at the pub ;)

Whoops. Guess I was too keen to get there myself. Thanks for picking that up!

> cheers
