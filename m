Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2595ADDE36
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 00:08:58 +1000 (EST)
In-Reply-To: <200709040940.04801.bbuchli@xes-inc.com>
References: <200708221337.21729.bbuchli@xes-inc.com>
	<662F11BD-C521-4914-966C-8FCB84D5F808@kernel.crashing.org>
	<200709040940.04801.bbuchli@xes-inc.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F3300B35-6C18-451B-83A1-7D3F1FE64E67@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: ppc Floating Point support status
Date: Wed, 5 Sep 2007 09:11:22 -0500
To: Ben Buchli <bbuchli@xes-inc.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 4, 2007, at 9:40 AM, Ben Buchli wrote:

> On Wednesday 22 August 2007 15:52:09 Kumar Gala wrote:
>> On Aug 22, 2007, at 1:37 PM, Ben Buchli wrote:
>>> Hello everybody,
>>> I was wondering what the status was on supporting floating-point
>>> instructions
>>> for the mpc8548.  I found the suggested patch:
>>> http://patchwork.ozlabs.org/linuxppc/patch?
>>> order=patch&filter=none&id=9455,
>>> but I'm not sure for what kernel version this is and when it will be
>>> officially supported.
>>>
>>> Thanks a lot for your help!
>>>
>>> Please CC to me (bbuchli at xes-inc.com) as I haven't subscribed to
>>> this list.
>>
>> I thing these are still up in the air based on having some sense of
>> testing related to them.
>>
>> - k
>
> Kumar,
> thanks for getting back with me.
> We're doing some early performance testing on one of our boards  
> with an
> mpc8548e. I was wondering if there's a snapshot available that we  
> could use
> and maybe do some working/testing on.
> Thanks a lot.

I'm confused as to what you are looking for.  Is 2.6.23-rc5 not  
sufficient?

- k
