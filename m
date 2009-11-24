Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C6C9DB6EEC
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 Nov 2009 08:08:31 +1100 (EST)
In-Reply-To: <4B0C2002.4050704@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<3D2BF5CA-C4BE-4250-8EC9-7A8E767572E2@kernel.crashing.org>
	<4B0C2002.4050704@yahoo.es>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7129FD29-82CE-4731-90F2-0EA6775EF861@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 06/19] powerpc: gamecube/wii: introduce GAMECUBE_COMMON
Date: Tue, 24 Nov 2009 22:15:14 +0100
To: Albert Herranz <albert_herranz@yahoo.es>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>> Add a config option GAMECUBE_COMMON to be used as a dependency  
>>> for all
>>> options common to the Nintendo GameCube and Wii video game consoles.
>>
>> Maybe something like GAMECUBE_OR_WII instead?  "COMMON" is so
>> common it's meaningless.
>>
>
> I don't like either GAMECUBE_OR_WII.
> It looks as if it can be used to match options for the GAMECUBE  
> _or_ WII. But that's not the meaning of it.
>
> This option should be used only for options applicable to both the  
> GAMECUBE and WII, i.e. basically those options in the WII which  
> where "inherited" from the GAMECUBE to make it retro-compatible.
>
> If GAMECUBE_COMMON is unacceptable, maybe GAMECUBE_LEGACY or  
> GAMECUBE_COMPAT?

Maybe it's best to write GAMECUBE || WII in the places that use it,  
then?


Segher
