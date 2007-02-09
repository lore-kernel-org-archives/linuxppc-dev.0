Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9D4E2DDE3E
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 01:40:21 +1100 (EST)
In-Reply-To: <3E83A767-0E8C-41E3-A9C7-A231CD841EAF@kernel.crashing.org>
References: <32F3CC26D4DAC44E8ECD07155727A46E8B7E97@zch01exm20.fsl.freescale.net>
	<3E83A767-0E8C-41E3-A9C7-A231CD841EAF@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <543c39e820836fcfe2d93681a0657d57@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch][5/5] powerpc V2: Add the general support for Embedded
	Floating-Point instructions
Date: Fri, 9 Feb 2007 15:40:07 +0100
To: Kumar Gala <galak@kernel.crashing.org>
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> I thought we were going to have some general Kconfig option
>>> to enable all this?  EMDEDDED_FP_IEEE or something like that
>>
>> So that users have chance to enable/disable fully IEEE compliance?
>> Segher
>> had mentioned this, and it sounds reasonable.
>
> Its alot of code to bring in if you don't care about IEEE compliance.

Yes certainly, and that's important for embedded applications.

My point however is that this should be selectable *per process*
at runtime.  Compare to the AltiVec situation (where processes
can select (non-)IEEE behaviour by themselves); most tasks do
*not* want IEEE behaviour as it is just too expensive (and not
necessary for many applications).


Segher
