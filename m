Return-Path: <SRS0+f7cfbddb351789caec09+1872+infradead.org+dwmw2@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4EB37DDFB2
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Oct 2008 19:41:15 +1100 (EST)
Subject: Re: [PATCH] pata_of_platform: fix no irq handling
From: David Woodhouse <dwmw2@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20081007103723.0224671e@lxorguk.ukuu.org.uk>
References: <20081006172653.GA26427@oksana.dev.rtsoft.ru>
	<48EA77EF.6080502@genesi-usa.com>
	<20081006213209.GA13072@oksana.dev.rtsoft.ru>
	<48EABBD3.1010401@kernel.org>
	<20081007103723.0224671e@lxorguk.ukuu.org.uk>
Content-Type: text/plain
Date: Wed, 08 Oct 2008 09:40:54 +0100
Message-Id: <1223455254.3145.143.camel@macbook.infradead.org>
Mime-Version: 1.0
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

On Tue, 2008-10-07 at 10:37 +0100, Alan Cox wrote:
> Zero means no IRQ. Any platform with bits of code left over exposing IRQ
> 0 is already not supported by lots of driver code including libata.

...and must implement some kind of interrupt remapping crap just to work
around this bogus design decision.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation
