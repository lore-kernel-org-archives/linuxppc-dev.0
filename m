Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DFF8BDDEE8
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 16:37:17 +1000 (EST)
Message-Id: <B353EBCF-A080-41C7-B331-61D29C6F5C02@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <1213935232.194904.168421502953.qpush@coopers>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 0/9] powerpc: Add kernel support for POWER7 VSX. 
Date: Fri, 20 Jun 2008 01:37:07 -0500
References: <1213935232.194904.168421502953.qpush@coopers>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 19, 2008, at 11:13 PM, Michael Neuling wrote:

> The following set of patches adds Vector Scalar Extentions (VSX)
> support for POWER7.  Includes context switch, ptrace and signals  
> support.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
> Paulus: please consider for your 2.6.27 tree.
>
> Updated with comments from Kumar, Milton, Dave Woodhouse and Mark
> 'NKOTB' Nelson.
> - Changed thread_struct array definition to be cleaner
> - Updated CPU_FTRS_POSSIBLE
> - Updated Kconfig typo and dupilicate
> - Added comment to clarify ibm,vmx = 2 really means VSX.

One question I was wondering about is the "user space" view of VSX.   
Is the intent to have it seem like there is a unique register set for  
VSX separate from FP or AltiVec?

(This gets into what the ABI changes look like).

- k
