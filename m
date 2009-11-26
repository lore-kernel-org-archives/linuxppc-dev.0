Return-Path: <albert_herranz@yahoo.es>
Received: from smtp121.mail.ukl.yahoo.com (smtp121.mail.ukl.yahoo.com
	[77.238.184.52]) by ozlabs.org (Postfix) with SMTP id 0358C1007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 02:22:42 +1100 (EST)
Message-ID: <4B0E9D40.2090103@yahoo.es>
Date: Thu, 26 Nov 2009 16:22:40 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH 06/19] powerpc: gamecube/wii: introduce GAMECUBE_COMMON
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>	
	<3D2BF5CA-C4BE-4250-8EC9-7A8E767572E2@kernel.crashing.org>	
	<4B0C2002.4050704@yahoo.es> <1259212129.16367.262.camel@pasglop>
In-Reply-To: <1259212129.16367.262.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Tue, 2009-11-24 at 19:03 +0100, Albert Herranz wrote:
>> Segher Boessenkool wrote:
>>>> Add a config option GAMECUBE_COMMON to be used as a dependency for all
>>>> options common to the Nintendo GameCube and Wii video game consoles.
>>> Maybe something like GAMECUBE_OR_WII instead?  "COMMON" is so
>>> common it's meaningless.
>>>
>> I don't like either GAMECUBE_OR_WII.
>> It looks as if it can be used to match options for the GAMECUBE _or_ WII. But that's not the meaning of it.
>>
>> This option should be used only for options applicable to both the GAMECUBE and WII, i.e. basically those options in the WII which where "inherited" from the GAMECUBE to make it retro-compatible.
>>
>> If GAMECUBE_COMMON is unacceptable, maybe GAMECUBE_LEGACY or GAMECUBE_COMPAT?
> 
> I don't have any strong opinion. Maybe NINTENDO_COMMON ?
> 

We should avoid using NINTENDO just to refer to the Nintendo GameCube or Wii. They have other consoles too :)
There's even a port of Linux to the Nintendo DS...

I'd stick to GAMECUBE_COMMON or GAMECUBE_COMPAT.

> Cheers,
> Ben.
> 

Thanks,
Albert
