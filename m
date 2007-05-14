Return-Path: <tglx@linutronix.de>
Received: from mail.tglx.de (www.osadl.org [213.239.205.134])
	by ozlabs.org (Postfix) with ESMTP id A8FE5DDE38
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 17:11:37 +1000 (EST)
Subject: Re: [patch 4/4] powerpc 2.6.21-rt1: reduce scheduling latency by
	changing tlb flush size
From: Thomas Gleixner <tglx@linutronix.de>
To: Tsutomu OWA <tsutomu.owa@toshiba.co.jp>
In-Reply-To: <yyiveev9afk.wl@toshiba.co.jp>
References: <yyi3b1zapqa.wl@toshiba.co.jp> <yyiwszb9asq.wl@toshiba.co.jp>
	<yyiveev9afk.wl@toshiba.co.jp>
Content-Type: text/plain
Date: Mon, 14 May 2007 08:51:46 +0200
Message-Id: <1179125506.22481.297.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, mingo@elte.hu, linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tsutomu-san,

On Mon, 2007-05-14 at 15:38 +0900, Tsutomu OWA wrote:
> Oopps, Subject was wrong.... resending it.  Sorry.
> 
> To reduce scheduling latecy by changing tlb flush size to 1.
> Since tlb flush on Celleb is done by calling (an) expensive hypervisor call(s), 
> it takes a long time to flush tlbs and causes scheduing latency.
> 
> As I don't know how long it takes on other platforms, it would be better to 
> enclose it within #ifdef CONFIG_PPC_CELLEB.

Yes, that might be appropriate. Can you add this and resend please ?

	tglx
