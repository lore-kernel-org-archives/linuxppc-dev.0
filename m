Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id E96A067EB1
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Oct 2006 06:03:59 +1000 (EST)
In-Reply-To: <45411B46.9060106@ru.mvista.com>
References: <20061026104338.99e89782.vwool@ru.mvista.com>	<4A3EAE00-3647-4B72-8CDF-ED6E0ADEC910@kernel.crashing.org>
	<1161894389.2820.14.camel@barja> <45411B46.9060106@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1093E9E4-5FDC-4AF7-9065-6236B0482CA4@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [1/2] build failure for E500 CPUs w/ CONFIG_OPROFLE=y
Date: Fri, 27 Oct 2006 15:03:51 -0500
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Vitaly Wool <vwool@ru.mvista.com>, oprofile-list@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 26, 2006, at 15:32, Sergei Shtylyov wrote:

> Hello.
>
> Vitaly Wool wrote:
>> Hello Kumar,
>
>>> This makes sense to me since we are just increasing kernel code size
>>> for code we would never use for an FSL_BOOKE part if we do it the
>>> other way.  I dont think its that much more messy with the ifdef's.
>
>> Okay, if you're fine with this patch, is it possible that you  
>> include it
>> into your tree?
>
>>> If you want to do the other cleanup as well I've got no issue with
>>> that, but we really should NOT build in support for 7450 into a
>>> FSL_BOOKE kernel when reasonably avoidable.
>
>> That's fine with me.
>> As of the cleanups, well... looks to me some more patches will follow
>> soon, kinda bugfixing ones rather than cleanups first :)
>
>    The most funny/stupd thing is that the patch existed since May  
> but it never
> went in:
>
> http://patchwork.ozlabs.org/linuxppc/patch?id=5531


Yeah, I guess it got lost.  After looking at both patches, I see the  
different approaches.  I think I'd vote for the older patch, since it  
also solves some SMP issues that will crop up when the dual-core 8572  
comes out.  In fact, it's similar to this patch: http:// 
patchwork.ozlabs.org/linuxppc/patch?id=4012

Oi.  Ok, I'm going to update and resend that patch in just a second  
(Ok, this took longer than I thought, due to the lwsync patch I sent  
out being required).  I like Vitaly's patch, but the one I sent  
cleans up some early design mistakes I made in the original ppc32  
oprofile code.



>
>> Thanks,
>>   Vitaly
>
> WBR, Sergei
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
