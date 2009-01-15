Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 693B6DE263
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 06:00:04 +1100 (EST)
Message-Id: <FA9675B0-0DC7-46DF-B2F5-A5370A15AF0A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
In-Reply-To: <20090115175456.GA11405@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] cpm2: Round the baud-rate clock divider to the nearest
	integer.
Date: Thu, 15 Jan 2009 12:57:44 -0600
References: <200811201332.24061.laurentp@cse-semaphore.com>
	<200901151418.28882.laurentp@cse-semaphore.com>
	<98B0EC36-C1AE-44F0-98CC-F1AED0B9E299@kernel.crashing.org>
	<200901151558.50816.laurentp@cse-semaphore.com>
	<20090115175456.GA11405@ld0162-tx32.am.freescale.net>
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Vitaly Bordug <vbordug@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 15, 2009, at 11:54 AM, Scott Wood wrote:

> On Thu, Jan 15, 2009 at 03:58:50PM +0100, Laurent Pinchart wrote:
>> On Thursday 15 January 2009 15:42:14 Kumar Gala wrote:
>>> On Jan 15, 2009, at 7:18 AM, Laurent Pinchart wrote:
>>>>
>>>> 2.6.29-rc1 is out and I haven't seen the patch being applied
>>>> anywhere. Is there any blocking issue ?
>>>
>>> I wasn't sure if you and Scott had come to resolution on the  
>>> rounding
>>> issue.
>>
>> I think we have. Scott, can you confirm ?
>
> I think the patch is correct, and I need to look into why it gives me
> problems on mpc8272ads (while solving similar issues on some other
> boards).

Ok.

Laurent,

Is this critical for 2.6.29 or ok if I queue for .30?

- k
