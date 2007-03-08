Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 871FADDEBB
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Mar 2007 06:10:27 +1100 (EST)
Subject: Re: [PATCH] Better timer and RTC handling for 8641HPCN.
From: Jon Loeliger <jdl@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1AEDE9F3-E4D4-4BB8-A0C7-D7D82BE29A4C@kernel.crashing.org>
References: <1173293364.23776.128.camel@ld0161-tx32>
	<150E096E-0304-4E48-985C-2F4D599196FE@kernel.crashing.org>
	<20070307193438.GA30721@ld0162-tx32.am.freescale.net>
	<CBC6BDF5-EB84-463C-A53C-1204CC396D5F@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C0DBE14@zch01exm26.fsl.freescale.net>
	<011CC9FF-E609-43A1-BC66-C57CC6233B4B@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C0DBE68@zch01exm26.fsl.freescale.net>
	<1AEDE9F3-E4D4-4BB8-A0C7-D7D82BE29A4C@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1173381017.23776.211.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Thu, 08 Mar 2007 13:10:17 -0600
Cc: linuxppc-dev@ozlabs.org, Zhang Wei-r63237 <Wei.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-03-07 at 23:57, Kumar Gala wrote:
> On Mar 7, 2007, at 11:38 PM, Zhang Wei-r63237 wrote:
> 
> > In fact, I've included <asm-generic/rtc.h> in mpc86xx_hpcn.c file, and
> > the file linux/mc146818rtc.h was included in asm-generic/rtc.h.
> 
> Uugh, sorry... was looking at asm/rtc.h not asm-generic/rtc.h (thus  
> my confusion)
> 
> I don't think we should add new users of the old rtc code at this  
> point.  We really should look at using the rtc class code.
> 
> I'm going to start a new thread on figuring out what we need to do  
> for ppc_md.set_rtc_time/ppc_md.get_rtc_time and the rtc subsystem.
> 
> - k

So, I kinda lost track of the fate of this change....
Is there a better way to write this?  Are we waiting for
you to start a discussion about this?  Or will it be
applied as is for now and fixed up (?) later?

And we're to change the NR_IRQS-10 to a hard 64 as well, right?

Thanks,
jdl
