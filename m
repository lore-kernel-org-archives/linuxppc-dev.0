Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EA4F1DDF9B
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 20:38:33 +1000 (EST)
Subject: Re: [PATCH 9/9] celleb: add support for PCI Express
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
In-Reply-To: <20080424.192739.1791044876.kouish@swc.toshiba.co.jp>
References: <20080424.192739.1791044876.kouish@swc.toshiba.co.jp>
Content-Type: text/plain
Date: Thu, 24 Apr 2008 20:38:27 +1000
Message-Id: <1209033507.9060.185.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2008-04-24 at 19:27 +0900, Ishizaki Kou wrote:
> This patch adds support for PCI Express port on Celleb. I/O space
> of this PCI Express port is not mapped in memory space. So we use
> the io-workaround mechanism to make accesses indirect.
> 
> I send this patch again because it would be lost.
> 
> Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---

Looks good. Doesn't affect non-celleb. I have no time to do a proper
test tonight but I think it's good to go.

Ack.

Cheers,
Ben.
