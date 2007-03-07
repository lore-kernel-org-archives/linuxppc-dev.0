Return-Path: <mingo@elte.hu>
Received: from fallback.mail.elte.hu (fallback.mail.elte.hu [157.181.151.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1D767DDF11
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Mar 2007 20:48:58 +1100 (EST)
Received: from mx2.mail.elte.hu ([157.181.151.9])
	by fallback.mail.elte.hu with esmtp (Exim) id 1HOs6a-0005sV-1n
	from <mingo@elte.hu>
	for <linuxppc-dev@ozlabs.org>; Wed, 07 Mar 2007 10:06:40 +0100
Date: Wed, 7 Mar 2007 10:05:50 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Tsutomu OWA <tsutomu.owa@toshiba.co.jp>
Subject: Re: [patch 0/7 -rt] powerpc 2.6.20-rt8: fix build breakage for
	PowerPC(ppc64)
Message-ID: <20070307090550.GA1783@elte.hu>
References: <yyik5xt27c0.wl@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <yyik5xt27c0.wl@toshiba.co.jp>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Tsutomu OWA <tsutomu.owa@toshiba.co.jp> wrote:

> 
> Hi Ingo,
> 
>   Please apply.
> 
>   This series of patches fixes build breakage on arch/powerpc with 
> realtime preempt patch.  This applies on top of linux-2.6.20 and 
> patch-2.6.20-rt8.

thanks, applied - these fixes all look straightforward and clean.

	Ingo
