Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id F1A73B7CDB
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jan 2010 21:00:29 +1100 (EST)
Date: Tue, 19 Jan 2010 02:00:38 -0800 (PST)
Message-Id: <20100119.020038.152864417.davem@davemloft.net>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] ucc_geth: Fix full TX queue processing
From: David Miller <davem@davemloft.net>
In-Reply-To: <20100118154750.GA9224@oksana.dev.rtsoft.ru>
References: <20100118154750.GA9224@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, B06378@freescale.com,
	lsorense@csclub.uwaterloo.ca
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Vorontsov <avorontsov@ru.mvista.com>
Date: Mon, 18 Jan 2010 18:47:50 +0300

> From: Jiajun Wu <b06378@freescale.com>
> 
> commit 7583605b6d29f1f7f6fc505b883328089f3485ad ("ucc_geth: Fix empty
> TX queue processing") fixed empty TX queue mishandling, but didn't
> account another corner case: when TX queue becomes full.
> 
> Without this patch the driver will stop transmiting when TX queue
> becomes full since 'bd == ugeth->txBd[txQ]' actually checks for
> two things: queue empty or full.
> 
> Let's better check for NULL skb, which unambiguously signals an empty
> queue.
> 
> Signed-off-by: Jiajun Wu <b06378@freescale.com>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Applied.
