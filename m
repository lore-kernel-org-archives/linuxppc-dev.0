Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 66456DE085
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 04:21:22 +1000 (EST)
Message-Id: <2FC90D95-762E-41D7-AD4E-64362B624BF8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080617162309.GA3217@loki.buserror.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH v2] powerpc/booke: Add support for new e500mc core
Date: Tue, 17 Jun 2008 13:19:48 -0500
References: <Pine.LNX.4.64.0806170901140.15775@blarg.am.freescale.net>
	<20080617162309.GA3217@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 17, 2008, at 11:23 AM, Scott Wood wrote:

> On Tue, Jun 17, 2008 at 09:01:39AM -0500, Kumar Gala wrote:
>> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/ 
>> platforms/Kconfig.cputype
>> index f7efaa9..1a1ccfb 100644
>> --- a/arch/powerpc/platforms/Kconfig.cputype
>> +++ b/arch/powerpc/platforms/Kconfig.cputype
>> @@ -95,6 +95,11 @@ config E500
>> 	select FSL_EMB_PERFMON
>> 	bool
>>
>> +config PPC_E500MC
>> +	bool "e500mc Support"
>> +	select PPC_FPU
>> +	depends on E500
>
> We should probably depend on !PPC_85xx until we can support such a
> configuration, rather than have it break in less obvious ways.

I don't see any reason for this.  While our marketing may say its not  
an 85xx anymore its pretty close to one.  For example I plan on the  
board code living in platforms/85xx.

- k
