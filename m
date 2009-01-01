Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 25477DDEDD
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Jan 2009 01:29:51 +1100 (EST)
Message-Id: <950062C1-9944-4B34-9D1D-18F35E1933E2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20081231174125.GA13027@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH v2 4/4] powerpc/83xx: Add PCI-E support for all MPC83xx
	boards with PCI-E
Date: Thu, 1 Jan 2009 08:29:39 -0600
References: <20081229164040.GD8215@oksana.dev.rtsoft.ru>
	<C96CE59B-05FA-4728-930F-D4430EFB9B99@kernel.crashing.org>
	<20081230201916.GA20059@oksana.dev.rtsoft.ru>
	<1F7739C2-930B-49C1-B8FF-679AF1BBAEAE@kernel.crashing.org>
	<20081231174125.GA13027@oksana.dev.rtsoft.ru>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 31, 2008, at 11:41 AM, Anton Vorontsov wrote:

> On Wed, Dec 31, 2008 at 10:48:07AM -0600, Kumar Gala wrote:
>>
>> On Dec 30, 2008, at 2:19 PM, Anton Vorontsov wrote:
>>
>>>>>
>>>>>
>>>>> +		compatible = "fsl,mpc8315-pcie", "fsl,mpc8314-pcie";
>>>>> +		reg = <0xe0009000 0x00001000 0xb0000000 0x01000000>;
>>>>
>>>> the size on the 0xb0000000 seems wrong
>>>
>>> This is how FSL U-Boots configure the cfg window, and I'm trying to
>>> retain the compatibility. Anyway, now Linux maps only the first 4kB
>>> of that area, so we don't actually care about this, but dts is still
>>> correct for older u-boots. Newer U-Boots might want to correct this
>>> value if they want to use other cfg window setup...
>>
>> I'd rather not pollute the .dts with this
>
> So you prefer to change the cfg window size to 0x1000?

I'd prefer to drop it (assuming that is reasonable).

Does the PCI-express OF draft spec cover describing cfg space

http://playground.sun.com/1275/proposals/New/516-it.txt

- k
