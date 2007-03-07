Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 52946DDF4F
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Mar 2007 20:14:25 +1100 (EST)
Date: Wed, 7 Mar 2007 10:13:41 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Tsutomu OWA <tsutomu.owa@toshiba.co.jp>
Subject: Re: [patch 0/6 -rt] powerpc 2.6.20-rt8: fix boot/runtime
	errors/warnings for PowerPC(ppc64)
Message-ID: <20070307091340.GB1783@elte.hu>
References: <yyi8xe925vg.wl@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <yyi8xe925vg.wl@toshiba.co.jp>
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
>   Please consider for inclusion in your rt tree.
> 
>   This series of patches fixes boot and runntime errors/warnings for
> powerpc (esp. 64 bit).  This applies to linux-2.6.20, patch-2.6.20-rt8
> and previous my patch set;
>   http://ozlabs.org/pipermail/linuxppc-dev/2007-March/032640.html
>   http://lkml.org/lkml/2007/3/6/503

thanks, applied.

	Ingo
