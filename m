Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EE09CDDE18
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 00:01:22 +1000 (EST)
In-Reply-To: <46CC2FB3.4000200@freescale.com>
References: <18124.1591.112487.322248@cargo.ozlabs.ibm.com>
	<46CC2FB3.4000200@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C3CB0CDB-AA2B-4D24-AEA6-1A7305B5B311@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Patches added to powerpc.git for-2.6.24 branch
Date: Wed, 22 Aug 2007 09:03:17 -0500
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 22, 2007, at 7:44 AM, Timur Tabi wrote:

> Paul Mackerras wrote:
>
>> Scott Wood (15):
>>       [POWERPC] Add clrbits8 and setbits8
>
> No love for my similar patch that adds the clrsetbits macros? Or  
> the one that changes immap_86xx.h?

I think the clrsetbits macros needs some further cleanup.  I think  
Stephen mentioned doing something like we do for DEF_MMIO_OUT_BE() to  
only have one 'actual' macro.

The immap_86xx.h will go through me since its FSL code.

- k
