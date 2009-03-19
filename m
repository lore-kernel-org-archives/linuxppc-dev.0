Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 5D617DDDA0
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 17:49:10 +1100 (EST)
Date: Wed, 18 Mar 2009 23:48:57 -0700 (PDT)
Message-Id: <20090318.234857.225870884.davem@davemloft.net>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH -next] gianfar, ucc_geth: Use proper address
	translation for MDIO buses
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090318192152.GA29621@oksana.dev.rtsoft.ru>
References: <20090318192152.GA29621@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org, afleming@freescale.com,
	scottwood@freescale.com, leoli@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Anton Vorontsov <avorontsov@ru.mvista.com>
Date: Wed, 18 Mar 2009 22:21:52 +0300

> David, I believe Kumar would like to pick this patch into his tree
> along with a patch set that adds "ranges = <>" properties to the
> device tree... So would you mind if we take it via powerpc.git?

No problem, and feel free to add my ack:

Acked-by: David S. Miller <davem@davemloft.net>
