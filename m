Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4D0F41007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 23:05:28 +1100 (EST)
In-Reply-To: <1259212129.16367.262.camel@pasglop>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<3D2BF5CA-C4BE-4250-8EC9-7A8E767572E2@kernel.crashing.org>
	<4B0C2002.4050704@yahoo.es> <1259212129.16367.262.camel@pasglop>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <59F72D0B-B28C-48E9-9328-65F4844A8826@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 06/19] powerpc: gamecube/wii: introduce GAMECUBE_COMMON
Date: Fri, 27 Nov 2009 13:12:26 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Albert Herranz <albert_herranz@yahoo.es>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>>> Add a config option GAMECUBE_COMMON to be used as a dependency  
>>>> for all
>>>> options common to the Nintendo GameCube and Wii video game  
>>>> consoles.
>>>
>>> Maybe something like GAMECUBE_OR_WII instead?  "COMMON" is so
>>> common it's meaningless.
>>
>> I don't like either GAMECUBE_OR_WII.
>> It looks as if it can be used to match options for the GAMECUBE  
>> _or_ WII. But that's not the meaning of it.
>>
>> This option should be used only for options applicable to both the  
>> GAMECUBE and WII, i.e. basically those options in the WII which  
>> where "inherited" from the GAMECUBE to make it retro-compatible.
>>
>> If GAMECUBE_COMMON is unacceptable, maybe GAMECUBE_LEGACY or  
>> GAMECUBE_COMPAT?
>
> I don't have any strong opinion. Maybe NINTENDO_COMMON ?

That is much worse than GAMECUBE_COMMON.

Can you call the "common" option GAMECUBE, and have WII be for support
for whatever is new on the Wii?  Or is there some significant code that
is only needed on the old gamecube?


Segher
