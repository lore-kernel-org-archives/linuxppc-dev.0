Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0ABD9DDE0E
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 07:16:23 +1000 (EST)
Subject: Re: mpc8541 pci1 ioport allocation address space problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wang Jian <lark@linux.net.cn>
In-Reply-To: <48D8FC36.9080407@linux.net.cn>
References: <48D4DB89.3040607@linux.net.cn>
	<1222062464.12085.25.camel@pasglop>  <48D8FC36.9080407@linux.net.cn>
Content-Type: text/plain
Date: Wed, 24 Sep 2008 07:16:12 +1000
Message-Id: <1222204572.8277.13.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-09-23 at 22:24 +0800, Wang Jian wrote:
> 
> I had this patch and 2 fixes on dts applied simultaneously, and the
> board
> works. I thought this patch was necessary.
> 
> I reverted this patch and tried again, the board still works. Thanks
> for
> your insight.
> 
> Anyway, the io port read from /proc/ioports is misleading, so I wish
> it
> can be changed a little.
> 

Ordering things differently in the DTS so that the lower address bus
gets probed first might help.

Cheers
Ben.
