Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 72400DDF6C
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Mar 2007 07:34:28 +1100 (EST)
Date: Thu, 8 Mar 2007 14:34:21 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Better timer and RTC handling for 8641HPCN.
Message-Id: <20070308143421.5994d6dd.kim.phillips@freescale.com>
In-Reply-To: <1AEDE9F3-E4D4-4BB8-A0C7-D7D82BE29A4C@kernel.crashing.org>
References: <1173293364.23776.128.camel@ld0161-tx32>
	<150E096E-0304-4E48-985C-2F4D599196FE@kernel.crashing.org>
	<20070307193438.GA30721@ld0162-tx32.am.freescale.net>
	<CBC6BDF5-EB84-463C-A53C-1204CC396D5F@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C0DBE14@zch01exm26.fsl.freescale.net>
	<011CC9FF-E609-43A1-BC66-C57CC6233B4B@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C0DBE68@zch01exm26.fsl.freescale.net>
	<1AEDE9F3-E4D4-4BB8-A0C7-D7D82BE29A4C@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Wei.Zhang@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 7 Mar 2007 23:57:36 -0600
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
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
yes, removing the ppc_md hooks and configuring RTC_DRV_CMOS might be a more appropriate thing to do for this board.

Kim
