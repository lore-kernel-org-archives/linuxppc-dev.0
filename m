Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E33B6B7282
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Jun 2009 22:50:34 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0F317DDD1B
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jun 2009 22:50:33 +1000 (EST)
Message-Id: <E57BFC08-F847-463A-9D0F-55979C4B0524@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <19001.31508.901222.288946@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH 5/6] perf_counter: powerpc: Add processor back-end for
	MPC7450 family
Date: Thu, 18 Jun 2009 07:50:10 -0500
References: <19000.55404.103840.393470@cargo.ozlabs.ibm.com>
	<19000.55631.802122.696927@cargo.ozlabs.ibm.com>
	<34BD6A89-A05E-40CC-A495-017BFB08B796@kernel.crashing.org>
	<19001.31508.901222.288946@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 17, 2009, at 6:24 PM, Paul Mackerras wrote:

> Kumar Gala writes:
>
>> This should be something like:
>>
>> obj64-$(CONFIG_PPC_PERF_CTRS)-$(PPC_BOOK3S_64)
>>
>>> +obj32-$(CONFIG_PPC_PERF_CTRS)	+= mpc7450-pmu.o
>>
>> obj32-$(CONFIG_PPC_PERF_CTRS)-$(PPC_BOOK3S_32)
>>
>> Or use new Kconfig types as I suggested on patch 1/6
>
> Feel free to send a patch making those changes along with adding the
> code to support the Freescale embedded PMU. :)
>
> Paul.

In looking at doing this what suggestions do you have in implementing  
perf_instruction_pointer() if we don't have the equivalent of SIAR.   
Just use regs->nip ?

- k
