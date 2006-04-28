Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 57A5D679F6
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Apr 2006 00:22:14 +1000 (EST)
In-Reply-To: <20060428111942.GA15646@suse.de>
References: <20060424173246.GA22318@suse.de>
	<17489.63055.968862.256370@cargo.ozlabs.ibm.com>
	<20060428111942.GA15646@suse.de>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <27BDABD8-B970-4F2C-AA0A-07D55A9D3303@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: alignment exceptionhandler sleeps in invalid context
Date: Fri, 28 Apr 2006 09:22:11 -0500
To: Olaf Hering <olh@suse.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 28, 2006, at 6:19 AM, Olaf Hering wrote:

>  On Fri, Apr 28, Paul Mackeras wrote:
>
>> Olaf Hering writes:
>>
>>> I'm not sure where the bug is. Does it mean the network stack does
>>> something nasty, or is the exception handler itself broken?  
>>> (probably the latter)
>>> This is 2.6.16.9 on a p270.
>>
>> This patch should fix it, I hope.  If you can verify that it fixes it
>> I'll send it to Linus.
>
> I dont have a testcase, it just happend once on the p270.

I was going to ask how this was actually hit.  It seems odd that we  
would have an alignment error in the network stack.  From the oops  
can we determine what the instruction was that faulted and what  
address it was trying to access.

- k
