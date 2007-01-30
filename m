Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C23D8DDEBF
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 09:36:01 +1100 (EST)
In-Reply-To: <Pine.LNX.4.60.0701302301250.15262@poirot.grange>
References: <Pine.LNX.4.60.0701252333210.13557@poirot.grange>
	<EB5DC4AE-E872-432E-A078-79A4385D6D52@kernel.crashing.org>
	<Pine.LNX.4.60.0701302301250.15262@poirot.grange>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8E9D9D0A-80B5-4861-8612-7ABAF4815C4D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 82xx CPU features
Date: Tue, 30 Jan 2007 16:35:03 -0600
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 30, 2007, at 4:31 PM, Guennadi Liakhovetski wrote:

> On Fri, 26 Jan 2007, Kumar Gala wrote:
>
>> For _CAN_NAP, I'm guessing its historic, maybe Dan knows why it  
>> wasn't set.
>> What happens if you try to set it?  Are there implications at the  
>> system level
>> with regards to _CAN_NAP?
>
> Just tested: set CPU_FTR_MAYBE_CAN_DOZE for 82xx, CONFIG_BDI_SWITCH  
> is not
> defined, echoed 1 to /proc/sys/kernel/powersave-nap - and a 8241 still
> runs... I'll try to measure if there's any difference in power
> consumption:-))
>
>> I'm looking at the CPU_FTR_PPC_LE it varies if we should use  
>> _PPC_LE vs
>> _TRUE_LE (or whatever the other one is called).

It would be good for someone to test an 8260 class (826x, 8272,  
etc..) to see if they have any issues.

- k
