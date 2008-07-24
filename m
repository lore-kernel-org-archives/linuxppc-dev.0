Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 14710DE163
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 01:12:42 +1000 (EST)
Message-Id: <524AC131-C155-416F-A8D7-EF1C6FD9A35B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
In-Reply-To: <200807241647.00564.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCHv3 1/2] [POWERPC] CPM2: Implement GPIO LIB API on CPM2
	Freescale SoC.
Date: Thu, 24 Jul 2008 10:12:31 -0500
References: <4808D75B.9000002@scram.de> <4880B730.8050801@scram.de>
	<C98DF5D7-0E3D-4FDA-A831-55CFD5F4590C@kernel.crashing.org>
	<200807241647.00564.laurentp@cse-semaphore.com>
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 24, 2008, at 9:46 AM, Laurent Pinchart wrote:

> Hi Kumar,
>
> On Friday 18 July 2008, Kumar Gala wrote:
>> On Jul 18, 2008, at 10:30 AM, Jochen Friedrich wrote:
>>>> On Jun 18, 2008, at 12:08 PM, Laurent Pinchart wrote:
>>>>
>>>>> +#if defined(CONFIG_CPM2) || defined(CONFIG_8xx_GPIO)
>>>>> +
>>>>> +struct cpm2_ioports {
>>>>> +	u32 dir, par, sor, odr, dat;
>>>>> +	u32 res[3];
>>>>> +};
>>>>> +
>>>>
>>>> is this really common for both CPM2 and 8xx?  if so why the name?
>>>
>>> It is common to CPM2 and Port E of CPM1.
>>
>> but ports a-d are different on cpm1?  I guess I'd like to see both
>> patches to understand the commonality and differences.
>
> As Jorgen mentionned, both patches are still in patchwork:
>
> http://patchwork.ozlabs.org/linuxppc/patch?id=19045
> http://patchwork.ozlabs.org/linuxppc/patch?id=19386
>
> Would it be possible for you to review them in time for 2.6.27 ?

Yes.  Can you resend the first patch and add some details in the  
commit message about the fact we can also use this code for 8xx/CPM1  
port E.

- k
