Return-Path: <alexandre.belloni@bootlin.com>
Received: from mail.bootlin.com (mail.bootlin.com [62.4.15.54])
 by lists.ozlabs.org (Postfix) with ESMTP id 40WFZY0j21zDrDT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2018 19:41:24 +1000 (AEST)
Date: Wed, 25 Apr 2018 11:41:10 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-rtc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3] powerpc/powernv: Fix OPAL RTC driver OPAL_BUSY loops
Message-ID: <20180425094110.GC4813@piout.net>
References: <20180410114933.24581-1-npiggin@gmail.com>
 <20180410114933.24581-3-npiggin@gmail.com>
 <20180410120728.GC2745@piout.net>
 <20180410230136.7d0b357e@roar.ozlabs.ibm.com>
 <20180424183918.GF19011@piout.net>
 <87d0yo55ic.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87d0yo55ic.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 25/04/2018 13:28:27+1000, Michael Ellerman wrote:
> Alexandre Belloni <alexandre.belloni@bootlin.com> writes:
> > On 10/04/2018 23:01:36+1000, Nicholas Piggin wrote:
> >> On Tue, 10 Apr 2018 14:07:28 +0200
> >> Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:
> >> > > Fixes 	 ("powerpc/powernv: Add RTC and NVRAM support plus RTAS fallbacks"
> >> > > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >> > > Cc: linux-rtc@vger.kernel.org
> >> > > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >> > > ---
> >> > >  arch/powerpc/platforms/powernv/opal-rtc.c |  8 +++--
> >> > >  drivers/rtc/rtc-opal.c                    | 37 ++++++++++++++---------  
> >> > 
> >> > From what I understand, the changes in those files are fairly
> >> > independent, they should probably be separated to ease merging.
> >> 
> >> I'm happy to do that. It's using the same firmware call, so I thought
> >> a single patch would be fine. But I guess the boot call can be
> >> dropped from this patch because it does not  not solve the problem
> >> described in the changelog.
> >> 
> >> Would you be happy for the driver change to be merged via the powerpc
> >> tree? The code being fixed here came from the same original patch as
> >> a similar issue being fixed in the OPAL NVRAM driver so it might be
> >> easier that way.
> >
> > Ok then, just add my
> >
> > Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> >
> > and let it go through the powerpc tree.
> 
> Thanks.
> 
> It's still mostly an rtc patch by lines changed, so I changed the
> subject to:
> 
>   rtc: opal: Fix OPAL RTC driver OPAL_BUSY loops
> 

Great, thanks!


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
