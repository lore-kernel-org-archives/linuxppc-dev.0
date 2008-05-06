Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 871BDDDECF
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 08:06:14 +1000 (EST)
In-Reply-To: <20080506164915.3f15cfe8@zod.rchland.ibm.com>
References: <20080506150955.0fdcaa85@zod.rchland.ibm.com>
	<e568c51ffa5f865094b26827ef959aa1@kernel.crashing.org>
	<20080506164915.3f15cfe8@zod.rchland.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <22231049fb717d6df966d6be8415d3e0@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: arch/ppc is broken
Date: Wed, 7 May 2008 00:04:58 +0200
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> On a related note, arch/ppc defconfig doesn't even configure anymore;
>> common_defconfig was removed, but it is still the default.  What 
>> config
>> should we use as default now?
>
> I'd be willing to guess that the answer is "nothing".

Plain "defconfig" should use _something_.  Something that still exists,
even.

> You're welcome to use ebony_defconfig

Yeah, that's what I use again now.

> but that's just as much unmaintained as the rest
> of arch/ppc and only builds when someone doesn't break it.

That's more often than "never even starts to build" ;-)

>> Josh, I'll look into the build failure now.
>
> Masochist ;)

Sadist.


Segher
