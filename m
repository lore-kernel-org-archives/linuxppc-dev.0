Return-Path: <tsawyer+linuxppc@sandburst.com>
Received: from sandmail.sandburst.com (sandmail.sandburst.com [216.57.132.42])
	by ozlabs.org (Postfix) with ESMTP id 436FF67A70
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 Feb 2005 07:51:47 +1100 (EST)
Message-ID: <421F8FE1.6020102@sandburst.com>
Date: Fri, 25 Feb 2005 15:51:45 -0500
From: "Travis B. Sawyer" <tsawyer+linuxppc@sandburst.com>
MIME-Version: 1.0
To: Matt Porter <mporter@kernel.crashing.org>
References: <1628E43D99629C46988BE46087A3FBB91C4AA7@ep-01.EmbeddedPlanet.local>	<421F89A0.8070502@sandburst.com>
	<20050225133055.A28918@cox.net>
In-Reply-To: <20050225133055.A28918@cox.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: 2.6 4xx GPIO OCP driver?
Reply-To: tsawyer+linuxppc@sandburst.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Matt Porter wrote:
> On Fri, Feb 25, 2005 at 03:25:04PM -0500, Travis B. Sawyer wrote:
> 
>>Steven Blakeslee wrote:
>>>>In 2.4 we used the drivers/char/ibm_ocp_gpio.c module.  I see 
>>>>no such support in 2.6.10.  I perused the archives, found 
>>>>nothing
>>>I see it.  Drivers/char/ibm_gpio.c in Linux 2.6.10-rc3.
>>
<SNIPPAGE above>
> I didn't bother merging it upstream at one time. It wasn't clear
> if the driver had any value over just mmaping /dev/mem to bang
> on the couple gpio registers directly.

Matt:

Good point, and that'll work for 2.4 also, which means I don't have to 
support different usercode btw the two versions of the kernel.

Thanx,

Travis
