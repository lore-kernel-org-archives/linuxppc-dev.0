Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id 62C96679EA
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 May 2005 21:27:02 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j4ABVeIW008916
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 May 2005 14:31:41 +0300 (EEST)
Message-ID: <428096B2.2040300@intracom.gr>
Date: Tue, 10 May 2005 14:10:42 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Pantelis Antoniou <panto@intracom.gr>
References: <1115672263.9050.52.camel@jmcmullan.timesys>
	<428094E8.4060900@intracom.gr>
In-Reply-To: <428094E8.4060900@intracom.gr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: PPC_LINUX <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 2.6.11.7] Remove iopa()
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Pantelis Antoniou wrote:
> McMullan, Jason wrote:
> 
>> iopa() is stupid. Remove it.
>>
>>
>>
> 
> Jason take a look at virt_to_phys...
> 
> extern inline unsigned long virt_to_phys(volatile void * address)
> {
> #ifndef CONFIG_APUS
>         return (unsigned long) address - KERNELBASE;
> #else
>         return iopa ((unsigned long) address);
> #endif
> }
> 
> Maybe virt_to_xxx needs to go too?
> 

Oops sorry. Maybe APUS needs to go instead :)

Regards

Pantelis
