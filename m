Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8076DB7B7A
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 01:41:10 +1100 (EST)
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH RFC] gianfar: Make polling safe with IRQs disabled 
In-reply-to: <20091105142028.GB17171@oksana.dev.rtsoft.ru> 
References: <20091104225711.GA30844@oksana.dev.rtsoft.ru>
	<E1N62ti-0003iS-K2@jdl.com>
	<20091105142028.GB17171@oksana.dev.rtsoft.ru>
Date: Thu, 05 Nov 2009 08:41:06 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1N63WM-0003xK-PN@jdl.com>
Cc: linuxppc-dev@ozlabs.org, Jason Wessel <jason.wessel@windriver.com>,
	Andy Fleming <afleming@freescale.com>,
	David Miller <davem@davemloft.net>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> 
> Hm, then I'd better remove the #ifdef CONFIG_NETPOLL.
> 
> Interestingly though, why conn_track does the polling with irqs
> disabled, could be a bug in the conn_track? Because pretty much
> drivers assume that polling is called with IRQs enabled.
> 
> If it's easily reproducible, could you replace the printk() with
> WARN_ON(1) and post the backtrace? Or I can try to reproduce the
> issue if you tell me how.
> 
> Thanks!

Yeah, I can reproduce it.  I'll try and get that for you.

jdl
