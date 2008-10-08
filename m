Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BC4D6DDDED
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Oct 2008 20:01:19 +1100 (EST)
Date: Wed, 8 Oct 2008 10:00:25 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] pata_of_platform: fix no irq handling
Message-ID: <20081008100025.1c535401@lxorguk.ukuu.org.uk>
In-Reply-To: <1223455254.3145.143.camel@macbook.infradead.org>
References: <20081006172653.GA26427@oksana.dev.rtsoft.ru>
	<48EA77EF.6080502@genesi-usa.com>
	<20081006213209.GA13072@oksana.dev.rtsoft.ru>
	<48EABBD3.1010401@kernel.org>
	<20081007103723.0224671e@lxorguk.ukuu.org.uk>
	<1223455254.3145.143.camel@macbook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Li Yang <leoli@freescale.com>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Tejun Heo <tj@kernel.org>, Jeff Garzik <jgarzik@pobox.com>,
	Wang Jian <lark@linux.net.cn>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 08 Oct 2008 09:40:54 +0100
David Woodhouse <dwmw2@infradead.org> wrote:

> On Tue, 2008-10-07 at 10:37 +0100, Alan Cox wrote:
> > Zero means no IRQ. Any platform with bits of code left over exposing IRQ
> > 0 is already not supported by lots of driver code including libata.
> 
> ...and must implement some kind of interrupt remapping crap just to work
> around this bogus design decision.

I'll leave you to argue with Linus about that, but since that was the
decision back in 2005 (for good C reasons) we can safely rely on it.
