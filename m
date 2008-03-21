Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0D610DDF65
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2008 04:28:49 +1100 (EST)
In-Reply-To: <20080321072419.2372774b@hansolo.jdub.homelinux.org>
References: <1205943310-26323-1-git-send-email-sr@denx.de>
	<1206090031.8420.67.camel@pasglop> <200803211154.34027.sr@denx.de>
	<20080321072419.2372774b@hansolo.jdub.homelinux.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9638a186ce2754343d4d349e55c15e2a@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Add AMCC Glacier 460GT eval board dts
Date: Fri, 21 Mar 2008 18:28:38 +0100
To: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> As for the DTS, maybe a "compatible" property in the CPU might make 
>>> some
>>> sense with a content along the lines of "ppc440x6" or whatever rev of
>>> the 440 core it is.
>>>
>>> What do you think ?
>>
>> Good idea. I'll try to come up with a list for all existing 4xx SoC's 
>> and it's
>> core versions.
>
> I don't really care either way, but what does that buy us?  Merely
> documentation?

Obviously, as long as the kernel doesn't use the device tree for probing
the CPUs available, additions to the device tree here don't affect the
kernel at all ;-P


Segher
