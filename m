Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 61CEBDE0D6
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 10:27:40 +1100 (EST)
Subject: Re: [PATCH] pata_of_platform: fix no irq handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tejun Heo <tj@kernel.org>
In-Reply-To: <48F2F138.6020103@kernel.org>
References: <20081006172653.GA26427@oksana.dev.rtsoft.ru>
	<48F2F138.6020103@kernel.org>
Content-Type: text/plain
Date: Tue, 14 Oct 2008 10:27:14 +1100
Message-Id: <1223940434.8157.283.camel@pasglop>
Mime-Version: 1.0
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>,
	Jeff Garzik <jgarzik@pobox.com>, Wang Jian <lark@linux.net.cn>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-10-13 at 15:56 +0900, Tejun Heo wrote:
> Anton Vorontsov wrote:
> > When no irq specified the pata_of_platform fills the irq_res with -1,
> > which is wrong to do for two reasons:
> > 
> > 1. By definition, 'no irq' should be IRQ 0, not some negative integer;
> > 2. pata_platform checks for irq_res.start > 0, but since irq_res.start
> >    is unsigned type, the check will be true for `-1'.
> > 
> > Reported-by: Steven A. Falco <sfalco@harris.com>
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> 
> applied to #tj-upstream (will soon be sent upstream)

Hrm... I applied it to powerpc.git too :-) Hopefully the merge will sort
it out !

Cheers,
Ben.
