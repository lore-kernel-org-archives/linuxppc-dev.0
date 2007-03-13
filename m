Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C6241DDEFF
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Mar 2007 01:39:34 +1100 (EST)
In-Reply-To: <989B956029373F45A0B8AF02970818902DAF26@zch01exm26.fsl.freescale.net>
References: <989B956029373F45A0B8AF02970818902DAF26@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4F6311F1-3C9D-4F5C-B807-BCE5A48D91FF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: automatically select QE options
Date: Tue, 13 Mar 2007 09:38:37 -0500
To: Li Yang-r58472 <LeoLi@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Tabi Timur-B04825 <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 13, 2007, at 5:24 AM, Li Yang-r58472 wrote:

> Timur,
>
> ACK on removing choices for UCC_FAST and UCC_SLOW.
>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 6dfbd52..54dd66c 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -396,8 +396,6 @@ endchoice
>>
>>  config QUICC_ENGINE
>>  	bool
>> -	depends on PPC_MPC836x || PPC_MPC832x
>> -	default y
>>  	help
>>  	  The QUICC Engine (QE) is a new generation of communications
>>  	  coprocessors on Freescale embedded CPUs (akin to CPM in older
> chips).
>
> But I'd prefer QUICC_ENGINE option to depend on chip models rather  
> than
> boards.  Also the comment doesn't reflect this change.

We are going to make QUICC_ENGINE a selectable option like it is for  
CPM2.  I agree that selectable option should depend on chip rather  
than board.

- k
