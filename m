Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E4300DE05C
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Aug 2008 08:28:18 +1000 (EST)
Message-Id: <BF7C9A64-AABC-4624-8282-4BAC2D970009@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <48923A43.9040901@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH] powerpc: Fix whitespace merge in mpc8641 hpcn device tree
Date: Thu, 31 Jul 2008 17:28:09 -0500
References: <Pine.LNX.4.64.0807311709530.10954@blarg.am.freescale.net>
	<48923A43.9040901@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 31, 2008, at 5:18 PM, Jon Loeliger wrote:

> Kumar Gala wrote:
>> When we coverted the .dts to v1 we lost a space between the irq
>> and its polarity/sense information.  This causes a bit of chaos
>> as the reset of the blob is off by one cell.
>>
>> diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/ 
>> boot/dts/mpc8641_hpcn.dts
>> index ae08761..d665e76 100644
>> --- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
>> +++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
>> @@ -411,7 +411,7 @@
>> 			0xe000 0 0 1 &i8259 12 2
>> 			0xe100 0 0 2 &i8259 9 2
>> 			0xe200 0 0 3 &i8259 10 2
>> -			0xe300 0 0 4 &i8259 112
>> +			0xe300 0 0 4 &i8259 11 2
>
> Ouch.  That was probably my typo and fault.
>
> Apologies.

np.  It would be nice to see dtc warn about it, but that would  
probably be a bit difficult.

- k
