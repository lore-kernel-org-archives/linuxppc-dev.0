Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C8916DDE02
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 07:27:40 +1100 (EST)
Subject: Re: [PATCH] genirq: Set initial default irq affinity to just CPU0
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <8440180C-A3B1-4436-9CDF-C6BA9A01F8CD@kernel.crashing.org>
References: <1224863858-7933-1-git-send-email-galak@kernel.crashing.org>
	<20081024.161813.193686281.davem@davemloft.net>
	<1224970389.7654.473.camel@pasglop>
	<20081025.210412.206011121.davem@davemloft.net>
	<1225002815.7654.487.camel@pasglop>
	<8440180C-A3B1-4436-9CDF-C6BA9A01F8CD@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 28 Oct 2008 07:27:16 +1100
Message-Id: <1225139236.8004.21.camel@pasglop>
Mime-Version: 1.0
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	torvalds@osdl.org, maxk@qualcomm.com, tglx@linutronix.de,
	David Miller <davem@davemloft.net>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-10-27 at 08:43 -0500, Kumar Gala wrote:
> 
> While we have the comment the code appears not to really follow it.   
> We appear to write 1 << hard_smp_processor_id().

That code is called by each CPU that gets onlined and OR's it's
bit in the mask.

Ben.
