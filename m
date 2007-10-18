Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 74E27DDE37
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 02:16:26 +1000 (EST)
In-Reply-To: <989B956029373F45A0B8AF0297081890019B5BD8@zch01exm26.fsl.freescale.net>
References: <1192719847-25045-1-git-send-email-leoli@freescale.com>
	<1192719847-25045-2-git-send-email-leoli@freescale.com>
	<3551DBD0-5DCB-4ECE-8509-E99B010A6D07@kernel.crashing.org>
	<989B956029373F45A0B8AF0297081890019B5BD8@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <D9A3E80B-B554-4855-9A3C-0AC76703542F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v6 2/9] ipic: add new interrupts introduced by new chip
Date: Thu, 18 Oct 2007 11:16:56 -0500
To: Li Yang-r58472 <LeoLi@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 18, 2007, at 10:29 AM, Li Yang-r58472 wrote:

>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>> Sent: Thursday, October 18, 2007 10:57 PM
>> To: Li Yang-r58472
>> Cc: paulus@samba.org; linuxppc-dev@ozlabs.org
>> Subject: Re: [PATCH v6 2/9] ipic: add new interrupts
>> introduced by new chip
>>
>>
>> On Oct 18, 2007, at 10:04 AM, Li Yang wrote:
>>
>>> These interrupts are introduced by the latest Freescale SoC such as
>>> MPC837x.  The patch also adds comment to interrupts.
>>>
>>> Signed-off-by: Li Yang <leoli@freescale.com>
>>> ---
>>>  arch/powerpc/sysdev/ipic.c |  224 +++++++++++++++++++++++++++++++++
>>> +----------
>>>  arch/powerpc/sysdev/ipic.h |    7 +-
>>>  include/asm-powerpc/ipic.h |   12 ++-
>>>  3 files changed, 186 insertions(+), 57 deletions(-)
>>
>> see comments:
>>
>> http://ozlabs.org/pipermail/linuxppc-dev/2007-October/044636.html
>
> But you didn't answer to my feedback
> http://ozlabs.org/pipermail/linuxppc-dev/2007-October/044711.html

sorry missed this.

> If you are so persistent on thinking it's harmful rather than useful,
> please at least attempt to persuade me.

The MPC5121e users the IPIC and has different interrupt assignment.
I suggest that the UMs be updated to more useful not the code.

- k
