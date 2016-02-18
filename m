Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C82371A0468
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 21:37:12 +1100 (AEDT)
Message-ID: <1455791827.5284.7.camel@ellerman.id.au>
Subject: Re: [PATCH 2/2] powerpc: Add POWER9 cputable entry
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 18 Feb 2016 21:37:07 +1100
In-Reply-To: <1455766350.22981.15.camel@neuling.org>
References: <1455685668-30198-1-git-send-email-mikey@neuling.org>
 <1455685668-30198-2-git-send-email-mikey@neuling.org>
 <1455707394.4450.4.camel@ellerman.id.au>
 <1455766350.22981.15.camel@neuling.org>
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

On Thu, 2016-02-18 at 14:32 +1100, Michael Neuling wrote:
> On Wed, 2016-02-17 at 22:09 +1100, Michael Ellerman wrote:
> > On Wed, 2016-02-17 at 16:07 +1100, Michael Neuling wrote:
> >
> > > Add a cputable entry for POWER9.  More code is required to actually
> > > boot and run on a POWER9 but this gets the base piece in which we
> > > can
> > > start building on.
> > >
> > > Copies over from POWER8 except for:
> > > - Adds a new CPU_FTR_ARCH_30 bit to start hanging new architecture
> >
> > ARCH thirty?
> >
> > Would CPU_FTR_ARCH_3 read better?
> >
> > Or CPU_FTR_ARCH_3_00 ?
>
> The actual architecture book used to say 2.07 but now says just 3.0.
> Hence why I picked 30 vs 207.

Yeah I get the logic.

> That being said, I don't really care what we call it.

I like CPU_FTR_ARCH_3.

cheers
