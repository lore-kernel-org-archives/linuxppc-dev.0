Return-Path: <SRS0+5a975b97460a6157554b+1319+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0EDD1DDF0F
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 10:13:34 +1000 (EST)
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
From: David Woodhouse <dwmw2@infradead.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20070403.170212.02298297.davem@davemloft.net>
References: <1175642916.10567.24.camel@shinybook.infradead.org>
	<20070403212928.GA12951@cynthia.pants.nu>
	<1175644642.10567.31.camel@shinybook.infradead.org>
	<20070403.170212.02298297.davem@davemloft.net>
Content-Type: text/plain
Date: Tue, 03 Apr 2007 20:12:48 -0400
Message-Id: <1175645568.10567.42.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-04-03 at 17:02 -0700, David Miller wrote:
> Sparc does the same thing, it's a common convention and you really
> should not break it.

I thought that argument was lost many years ago. It _used_ to be a
common convention; we got better.

> Every powerpc and sparc system out that is using ttyS0 with dynamic
> minor numbers being allocated.  I really think this should be
> generalized instead of breaking serial on every powerpc machine out
> there.

Nobody's breaking anything. The patch _fixes_ serial, and allows powerpc
machines to use both z8530 and 8250 ports at the same time; something
which has been broken for a long time.

-- 
dwmw2
