Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BBA37DDDE9
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 14:02:11 +1100 (EST)
Message-Id: <4130F47E-4F4A-4911-B63B-403A8C423565@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20080219.163003.152862383.davem@davemloft.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH v2][POWERPC] Fix initial lmb add region with a non-zero
	base
Date: Tue, 19 Feb 2008 21:02:04 -0600
References: <Pine.LNX.4.64.0802191350590.10089@blarg.am.freescale.net>
	<20080219.163003.152862383.davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 19, 2008, at 6:30 PM, David Miller wrote:

> From: Kumar Gala <galak@kernel.crashing.org>
> Date: Tue, 19 Feb 2008 13:51:37 -0600 (CST)
>
>> If we add to an empty lmb region with a non-zero base we will not  
>> coalesce
>> the number of regions down to one.  This causes problems on ppc32  
>> for the
>> memory region as its assumed to only have one region.
>>
>> We can fix this easily by causing the initial add to replace the  
>> dummy
>> region.
>>
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>> ---
>>
>> Fix a bug the initial patch introduced if we have a region that  
>> gets added
>> at the beginning of the list we wouldn't actually add it.
>>
>> Dave can you replace the patch in you tree with this one.
>
> I think my tree has already or will soon be pulled in so
> I don't want to rebase it.
>
> Why don't you simply send me the relative bug fix instead?

np.  Are we trying to get this into 2.6.25 or .26?

- k
