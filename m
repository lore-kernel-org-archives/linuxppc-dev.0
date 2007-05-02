Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 11DA0DDFA3
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 00:06:47 +1000 (EST)
In-Reply-To: <E98E4E57-2322-412F-A58E-A0CCC39DDCE3@kernel.crashing.org>
References: <Pine.LNX.4.64.0704191615040.25069@localhost.localdomain>
	<20070424000153.GD23995@crusty.rchland.ibm.com>
	<ada647m635h.fsf@cisco.com> <200704240746.05129.sr@denx.de>
	<E98E4E57-2322-412F-A58E-A0CCC39DDCE3@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E6D49EC6-F644-4666-BE78-76D7BABE4466@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: What defines a cpu table platform? (was Re: Change 440GP platform to
	ppc440)
Date: Wed, 2 May 2007 09:06:00 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 1, 2007, at 10:38 PM, Kumar Gala wrote:

>
> On Apr 24, 2007, at 12:46 AM, Stefan Roese wrote:
>
>> On Tuesday 24 April 2007 02:12, Roland Dreier wrote:
>>>>> I recall dimly that there was some user-visible difference
>>>>> between the
>>>>> 440GP and the other 440 processors, and that's why we made the
>>>>> platform string different.  I don't recall what the difference  
>>>>> was.
>>>
>>> FWIW, I've run the same userspace (binaries) on 405GPr, 440GP and
>>> 440SPe without any problems.  Not that I'm a 4xx expert by any
>>> stretch, but I don't know of anything special about the 440GP.
>>
>> I don't know of any differences either. So I'm voting to change the
>> platform
>> to ppc440 too.
>
> After some discussion with Paul we think we figured out why 440GP was
> marked differently.  I doesn't implement 'isel', and all other  
> 440's do.

This whole discussion makes me wondering what defines a new cpu table  
platform?  I know one application of this value is for being able to  
pick "platform" specific/tuned libraries.  Are there other uses?

If its just for libraries wouldn't the existence of FPUs and SPE/ 
Altivec warrant different platform types?

- k
