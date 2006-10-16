Return-Path: <kumar@kgala.com>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1C72A67C77
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Oct 2006 06:40:32 +1000 (EST)
In-Reply-To: <0371C551-B535-4B95-81F3-8CC95C4FFC82@kernel.crashing.org>
References: <871wp8ukh0.fsf@sleipner.barco.com>
	<1161029148.3172.19.camel@zod.rchland.ibm.com>
	<87slhot3pe.fsf@sleipner.barco.com>
	<0371C551-B535-4B95-81F3-8CC95C4FFC82@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F0164778-EE39-469A-A254-43377438AD81@kgala.com>
From: Kumar Gala <kumar@kgala.com>
Subject: Re: [PATCH] fix ARCH=ppc timer_interrupt after global pt_regs
Date: Mon, 16 Oct 2006 15:40:24 -0500
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Peter Korsgaard <jacmet@sunsite.dk>, paulus@samba.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 16, 2006, at 3:22 PM, Kumar Gala wrote:

>
> On Oct 16, 2006, at 3:18 PM, Peter Korsgaard wrote:
>
>>>>>>> "JB" == Josh Boyer <jwboyer@linux.vnet.ibm.com> writes:
>>
>> Hi,
>>
>> JB> Kumar Galak already fixed this on Oct 11 in the powerpc git tree.
>>
>> Ahh, I didn't notice.
>>
>> JB> Paul, could you send this fix to Linus soon please?
>>
>> Yes, please - I spend most of the morning tracking this down.
>
> Yeah, akpm picked up the patch for -mm.

Paul's got this in is powerpc.git tree now so it should go to Linus  
on his next pull request.

- k
