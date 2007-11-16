Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9FAD9DDDEB
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Nov 2007 02:56:34 +1100 (EST)
In-Reply-To: <20071116072415.95082DDDF2@ozlabs.org>
References: <20071116072415.95082DDDF2@ozlabs.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4ccc68f867a65d70f5d1e3ee946de4d1@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add xmon function to dump 44x TLB
Date: Fri, 16 Nov 2007 16:54:22 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +#ifdef CONFIG_44x
> +static void dump_tlb_44x(void);
> +#endif

No need to #ifdef this...

> +#ifdef CONFIG_44x
> +static void dump_tlb_44x(void)
> +{

...or this.


Segher
