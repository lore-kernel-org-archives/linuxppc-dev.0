Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 03FEADDE9A
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Aug 2007 02:09:40 +1000 (EST)
In-Reply-To: <20070818015542.b8e2df67.sfr@canb.auug.org.au>
References: <Pine.LNX.4.64.0708170823150.31758@blarg.am.freescale.net>
	<20070818015542.b8e2df67.sfr@canb.auug.org.au>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6E87D0B2-29EB-4068-9BF0-F8373C61B256@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Fix 8xx compile failure
Date: Fri, 17 Aug 2007 11:11:20 -0500
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 17, 2007, at 10:55 AM, Stephen Rothwell wrote:

> Hi Kumar,
>
> On Fri, 17 Aug 2007 08:24:02 -0500 (CDT) Kumar Gala  
> <galak@kernel.crashing.org> wrote:
>>
>> diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/ 
>> fsl_soc.c
>> index 727453d..f6943fc 100644
>> --- a/arch/powerpc/sysdev/fsl_soc.c
>> +++ b/arch/powerpc/sysdev/fsl_soc.c
>> @@ -36,6 +36,7 @@
>>  #include <sysdev/fsl_soc.h>
>>  #include <mm/mmu_decl.h>
>>  #include <asm/cpm2.h>
>> +#include <asm/of_platform.h>
>
> linux/of_platform.h should be used these days.

ok fixed.

- k
