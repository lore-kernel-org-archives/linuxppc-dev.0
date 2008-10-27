Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A4335DDE01
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Oct 2008 13:49:47 +1100 (EST)
Subject: Re: [PATCH] genirq: Set initial default irq affinity to just CPU0
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kevin Diggs <kevdig@hypersurf.com>
In-Reply-To: <490527CF.80908@hypersurf.com>
References: <1224863858-7933-1-git-send-email-galak@kernel.crashing.org>
	<20081024.161813.193686281.davem@davemloft.net>
	<1224970389.7654.473.camel@pasglop>  <4903A37A.50607@hypersurf.com>
	<1225003723.7654.490.camel@pasglop>  <490527CF.80908@hypersurf.com>
Content-Type: text/plain
Date: Mon, 27 Oct 2008 13:49:36 +1100
Message-Id: <1225075776.8004.0.camel@pasglop>
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

On Sun, 2008-10-26 at 18:30 -0800, Kevin Diggs wrote:
> The reason I asked is that I seem to remember a config option that
> would restrict the irqs to cpu 0? Help suggested it was needed for
> certain PowerMacs. Didn't provide any help as to which ones. My GigE
> currently spreads them between the two. I have not noticed any
> additional holes in the space time contiuum.

Yeah, a long time ago we had unexplained lockups when spreading
interrupts, hence the config option. I think it's all been fixed since
then.

Ben.
