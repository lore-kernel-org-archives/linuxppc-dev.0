Return-Path: <wfarnsworth@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 7523F67A75
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Mar 2005 08:38:50 +1100 (EST)
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: Jason McMullan <jason.mcmullan@timesys.com>
In-Reply-To: <1110920303.5937.103.camel@ad.doubleclick.net>
References: <1110907039.24673.12.camel@rhino.az.mvista.com>
	<20050315184153.GB28823@gate.ebshome.net>
	<1110913681.24673.42.camel@rhino.az.mvista.com>
	<1110920303.5937.103.camel@ad.doubleclick.net>
Content-Type: text/plain
Message-Id: <1110922726.24673.79.camel@rhino.az.mvista.com>
Mime-Version: 1.0
Date: 15 Mar 2005 14:38:46 -0700
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 1/3] PPC440EP SoC and Bamboo board support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 2005-03-15 at 13:58, Jason McMullan wrote:
> I think your setup for BAMBOO_PCIL0_PTM1MS is actually incorrect.
> According to the AMCC 440EP docs, BAMBOO_PCIL0_PTM1MS is a mask,
> so the correct code should look more like:
> 
>         memory_size = 0xffffffff - (memory_size - 1);
> 	PCI_WRITEL(memory_size | 1, BAMBOO_PCIL0_PTM1MS);
> 
> (assuming 'memory_size' is a power of 2)

Jason,

I think you're right.  Your way is much more concise too.

Thanks,
Wade Farnsworth
