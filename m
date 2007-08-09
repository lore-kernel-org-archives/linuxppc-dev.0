Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5956DDDE30
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 16:34:29 +1000 (EST)
In-Reply-To: <20070809053423.GJ8261@localhost.localdomain>
References: <20070807042050.GJ13522@localhost.localdomain>
	<BDA0DE7D-8AD8-4116-ABE0-2DF6AE72A516@kernel.crashing.org>
	<20070808110029.43c110ef@weaponx.rchland.ibm.com>
	<57F869A4-38DE-4CC9-A07D-C3A873CE9268@kernel.crashing.org>
	<20070809053423.GJ8261@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <CEBBAD6A-9C83-4E9A-9752-8F089894E56C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Fix small race in 44x tlbie function
Date: Thu, 9 Aug 2007 01:35:27 -0500
To: David Gibson <dwg@au1.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Volkmar Uhlig <vuhlig@us.ibm.com>,
	Paul Mackerras <paulus@samba.org>, Todd Inglett <tinglett@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>> Did you actually see this happen?
>>>
>>> Yes.
>>
>> When?
>>
>> We don't have critical wired to anything, I don't expect watchdog to
>> cause another fault.. so just wondering.
>
> On debug (trace) interrupts on blue gene.

Do you know why the debug code caused a fault?

- k
