Return-Path: <alexandre.belloni@bootlin.com>
Received: from mail.bootlin.com (mail.bootlin.com [62.4.15.54])
 by lists.ozlabs.org (Postfix) with ESMTP id 40VsYx0h2jzF24G
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2018 04:39:31 +1000 (AEST)
Date: Tue, 24 Apr 2018 20:39:18 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linux-rtc@vger.kernel.org
Subject: Re: [PATCH 2/3] powerpc/powernv: Fix OPAL RTC driver OPAL_BUSY loops
Message-ID: <20180424183918.GF19011@piout.net>
References: <20180410114933.24581-1-npiggin@gmail.com>
 <20180410114933.24581-3-npiggin@gmail.com>
 <20180410120728.GC2745@piout.net>
 <20180410230136.7d0b357e@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180410230136.7d0b357e@roar.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/04/2018 23:01:36+1000, Nicholas Piggin wrote:
> On Tue, 10 Apr 2018 14:07:28 +0200
> Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:
> > > Fixes 	 ("powerpc/powernv: Add RTC and NVRAM support plus RTAS fallbacks"
> > > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > Cc: linux-rtc@vger.kernel.org
> > > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > > ---
> > >  arch/powerpc/platforms/powernv/opal-rtc.c |  8 +++--
> > >  drivers/rtc/rtc-opal.c                    | 37 ++++++++++++++---------  
> > 
> > From what I understand, the changes in those files are fairly
> > independent, they should probably be separated to ease merging.
> 
> I'm happy to do that. It's using the same firmware call, so I thought
> a single patch would be fine. But I guess the boot call can be
> dropped from this patch because it does not  not solve the problem
> described in the changelog.
> 
> Would you be happy for the driver change to be merged via the powerpc
> tree? The code being fixed here came from the same original patch as
> a similar issue being fixed in the OPAL NVRAM driver so it might be
> easier that way.
> 

Ok then, just add my

Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

and let it go through the powerpc tree.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
