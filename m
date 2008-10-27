Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6ED8DDDDEE
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 07:46:57 +1100 (EST)
Message-Id: <4CC6D7AE-2970-47AE-8473-9013A613F837@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: benh@kernel.crashing.org
In-Reply-To: <1225139236.8004.21.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] genirq: Set initial default irq affinity to just CPU0
Date: Mon, 27 Oct 2008 15:45:59 -0500
References: <1224863858-7933-1-git-send-email-galak@kernel.crashing.org>
	<20081024.161813.193686281.davem@davemloft.net>
	<1224970389.7654.473.camel@pasglop>
	<20081025.210412.206011121.davem@davemloft.net>
	<1225002815.7654.487.camel@pasglop>
	<8440180C-A3B1-4436-9CDF-C6BA9A01F8CD@kernel.crashing.org>
	<1225139236.8004.21.camel@pasglop>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	torvalds@osdl.org, maxk@qualcomm.com, tglx@linutronix.de,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 27, 2008, at 3:27 PM, Benjamin Herrenschmidt wrote:

> On Mon, 2008-10-27 at 08:43 -0500, Kumar Gala wrote:
>>
>> While we have the comment the code appears not to really follow it.
>> We appear to write 1 << hard_smp_processor_id().
>
> That code is called by each CPU that gets onlined and OR's it's
> bit in the mask.

ahh, I see now.

- k
