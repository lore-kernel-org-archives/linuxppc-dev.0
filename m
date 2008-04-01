Return-Path: <xenidis@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id 66A8BDDE16
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 23:01:39 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so516800anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 01 Apr 2008 05:01:32 -0700 (PDT)
In-Reply-To: <1207019732.12155.81.camel@vader.jdub.homelinux.org>
References: <10aea37177130bbe5de7.1206969157@thinkpadL>
	<1206983237.12155.60.camel@vader.jdub.homelinux.org>
	<20080331130518.2a6b0264@zod.rchland.ibm.com>
	<1206987598.9165.10.camel@thinkpadL>
	<1207011862.7490.5.camel@concordia.ozlabs.ibm.com>
	<1207019732.12155.81.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <11F8A893-409D-4449-9DAB-BF248045E6D9@pobox.com>
From: Jimi Xenidis <jimix@pobox.com>
Subject: Re: [kvm-ppc-devel] [PATCH] Add idle power save for ppc 4xx
Date: Tue, 1 Apr 2008 08:01:22 -0400
To: Josh Boyer <jwboyer@gmail.com>
Sender: Jimi Xenidis <xenidis@gmail.com>
Cc: kvm-ppc-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 31, 2008, at 11:15 PM, Josh Boyer wrote:

> On Tue, 2008-04-01 at 12:04 +1100, Michael Ellerman wrote:
>>>>> I'm assuming you pass a dtb to the virtual guest when you start  
>>>>> it up.
>>>>> Could you define a property in the CPU node there that can be  
>>>>> parsed to
>>>>> use the power_save function instead of always making it the  
>>>>> default?
>>>>
>>>> Actually, you probably don't want this as a property in the device
>>>> tree.  It doesn't describe hardware.  A Kconfig option might be
>>>> warranted though.
>>>
>>> I'll go with the Kconfig option.
>>
>> Go with a device-tree check. The pseries kernel supports both bare- 
>> metal
>> and hypervisor in the same kernel image, and it works out which it's
>> running on by looking at the device-tree. This seems equivalent to  
>> me?
>
> After some back and forth on IRC, we decided on that as well.  I love
> being right, then wrong, then right again.

Awesome, can you summarize for the rest of us?
-JX
