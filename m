Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 303941A0BA2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Apr 2015 13:25:59 +1000 (AEST)
Message-ID: <1428463558.29968.0.camel@ellerman.id.au>
Subject: Re: [PATCH 0/8] powerpc/8xx: Getting rid of CONFIG_8xx
From: Michael Ellerman <mpe@ellerman.id.au>
To: Scott Wood <scottwood@freescale.com>
Date: Wed, 08 Apr 2015 13:25:58 +1000
In-Reply-To: <1428442269.22867.467.camel@freescale.com>
References: <20150312152420.11C821A2425@localhost.localdomain>
 <1426203271.2772.3.camel@ellerman.id.au>
 <1427244330.22867.76.camel@freescale.com> <5523932C.8070303@c-s.fr>
 <1428442269.22867.467.camel@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-04-07 at 16:31 -0500, Scott Wood wrote:
> On Tue, 2015-04-07 at 10:19 +0200, leroy christophe wrote:
> > Le 25/03/2015 01:45, Scott Wood a écrit :
> > > On Fri, 2015-03-13 at 10:34 +1100, Michael Ellerman wrote:
> > >> You'll need to collect ACKs, or get the individual patches merged, and then we
> > >> can take patch 8 through the powerpc tree once those are all in - probably for
> > >> 4.2.
> > > It looks like CONFIG_8xx is used a lot more than CONFIG_PPC_8xx, so it
> > > would be less churn to get rid of the latter (plus, we also have
> > > CONFIG_4xx, CONFIG_6xx, etc).  The only use of PPC_8xx I see outside
> > > arch/powerpc is in drivers/watchdog/Kconfig.
> > 
> > Ok, we can do that. But when outside of arch/powerpc/, isn't is more 
> > explicit with CONFIG_PPC_8xx rather that CONFIG_8xx ?
> 
> Yes, CONFIG_PPC_8xx is a better name, but churn and consistency matter
> as well.
> 
> > Now that I have submitted the first set of patch, don't we have a risk 
> > that now it is already merged by some other maintainers ?
> 
> Sigh.  I see a couple in linux-next.

Yeah, I think we missed the boat on that one.

cheers
