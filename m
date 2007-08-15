Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 84B2EDDEC9
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Aug 2007 22:12:30 +1000 (EST)
Message-ID: <46C2ED70.5010108@ru.mvista.com>
Date: Wed, 15 Aug 2007 16:11:28 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/4] PowerPC 440EPx: Sequoia defconfig
References: <20070814184107.GA6696@ru.mvista.com>	<20070814184500.GA10087@ru.mvista.com>
	<20070814142148.40bd7a57@zod.rchland.ibm.com>
In-Reply-To: <20070814142148.40bd7a57@zod.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> On Tue, 14 Aug 2007 22:45:00 +0400
> Valentine Barshak <vbarshak@ru.mvista.com> wrote:
> 
>> Sequoia defconfig
>>
>> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
>> ---
>>  arch/powerpc/configs/sequoia_defconfig |  783 +++++++++++++++++++++++++++++++++
>>  1 files changed, 783 insertions(+)
>>
>> diff -ruN linux-2.6.orig/arch/powerpc/configs/sequoia_defconfig linux-2.6/arch/powerpc/configs/sequoia_defconfig
>> --- linux-2.6.orig/arch/powerpc/configs/sequoia_defconfig	1970-01-01 03:00:00.000000000 +0300
>> +++ linux-2.6/arch/powerpc/configs/sequoia_defconfig	2007-08-14 17:18:07.000000000 +0400
>> @@ -0,0 +1,783 @@
>> +#
>> +# Automatically generated make config: don't edit
>> +# Linux kernel version: 2.6.23-rc1
>> +# Fri Jul 27 20:46:07 2007
>> +#
>> +# CONFIG_PPC64 is not set
>> +
>> +#
>> +# Processor support
>> +#
>> +# CONFIG_6xx is not set
>> +# CONFIG_PPC_85xx is not set
>> +# CONFIG_PPC_8xx is not set
>> +# CONFIG_40x is not set
>> +CONFIG_44x=y
>> +# CONFIG_E200 is not set
>> +CONFIG_PPC_FPU=y
> 
> ...
> 
>> +CONFIG_MATH_EMULATION=y
> 
> You shouldn't need both FPU and MATH_EMULATION.  Bamboo had the same
> bug in it's defconfig until recently, so you can blame me if you'd
> like :)
> 

OK, I'll correct this one.
Thanks for noticing that :)

> josh
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
