Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6A6E6DDDE7
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 18:38:17 +1000 (EST)
In-Reply-To: <20070802153222.6482ae85@weaponx.rchland.ibm.com>
References: <20070730151628.GA5100@ru.mvista.com>
	<20070801021541.GE31391@localhost.localdomain>
	<1a27a299b62c4b3a1a1f8fe8912e8e40@kernel.crashing.org>
	<20070801050542.GJ31391@localhost.localdomain>
	<20070802153222.6482ae85@weaponx.rchland.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B53DD351-58BF-4D89-9EEB-D0A3D260E2DA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 5/6] PowerPC 440EPx: Sequoia board support
Date: Fri, 3 Aug 2007 03:39:23 -0500
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 2, 2007, at 3:32 PM, Josh Boyer wrote:

> On Wed, 1 Aug 2007 15:05:42 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>
>> On Wed, Aug 01, 2007 at 07:01:17AM +0200, Segher Boessenkool wrote:
>>>>> +	{ /* 440EPX  - without Security/Kasumi  */
>>>>> +		.pvr_mask		= 0xf0000fff,
>>>>> +		.pvr_value		= 0x200008D4,
>>>>> +		.cpu_name		= "440EPX - no Security/Kasumi",
>>>>> +		.cpu_features		= CPU_FTRS_44X,
>>>>> +		.cpu_user_features	= COMMON_USER_BOOKE |  
>>>>> PPC_FEATURE_HAS_FPU, /*
>>>>> 440EPX has an FPU */
>>>>> +		.icache_bsize		= 32,
>>>>> +		.dcache_bsize		= 32,
>>>>> +	},
>>>>
>>>> Since the with/without Security/Kasumi versions have no  
>>>> differences in
>>>> their cputable entry other than the PVR, couldn't you just  
>>>> remove the
>>>> relevant PVR bit from the mask and use a single entry?
>>>
>>> And get rid of the stupid "has an FPU" comment at the same time
>>> please :-)
>>
>> Actually that comment may be worthwhile if expanded a little.  I  
>> think
>> the point is that 440EPx *unlike most other 4xx chips* has an  
>> FPU.  So
>> the point of the comment is not explaining the feature bit, which is
>> obvious, but as a "no, really, it does".
>
> Right.  440EP(x) are the only currently available 44x chips that
> contain an FPU, so I also think the comment can stay.

I agree w/Segher the comment is redundant.  Just make a note of the  
fact that we really have FPU in the commit message.

- k
