Return-Path: <becky.bruce@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AC95FDDF11
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 00:27:24 +1000 (EST)
In-Reply-To: <1AD7FFC7-8BEE-44C0-A28F-A36462C9B3EE@kernel.crashing.org>
References: <11787390792190-git-send-email-becky.bruce@freescale.com>
	<20070510091138.6e4fe0e6.sfr@canb.auug.org.au>
	<E00865DA-6E7E-4D9E-8F7A-2B35A8103163@freescale.com>
	<1AD7FFC7-8BEE-44C0-A28F-A36462C9B3EE@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4B675D0C-B9D7-40CF-A43D-4EB4AA56167E@freescale.com>
From: Becky Bruce <becky.bruce@freescale.com>
Subject: Re: [PATCH] Move reg_booke.h to include/asm-powerpc
Date: Thu, 10 May 2007 09:31:21 -0500
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 10, 2007, at 9:20 AM, Kumar Gala wrote:

>
> On May 10, 2007, at 8:44 AM, Becky Bruce wrote:
>
>>
>> On May 9, 2007, at 6:11 PM, Stephen Rothwell wrote:
>>
>>> On Wed,  9 May 2007 14:31:19 -0500 Becky Bruce
>>> <becky.bruce@freescale.com> wrote:
>>>>
>>>> This patch moves reg_booke.h from include/asm-ppc to include/asm-
>>>> powerpc.  This is
>>>> just a git-mv of the file; no changes were made.  Tested builds of
>>>> 8540 ADS and
>>>> Ebony platforms with ARCH=ppc and ARCH=powerpc.
>>>>
>>>> Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
>>>> ---
>>>>  include/{asm-ppc => asm-powerpc}/reg_booke.h |    0
>>>>  1 files changed, 0 insertions(+), 0 deletions(-)
>>>>  rename include/{asm-ppc => asm-powerpc}/reg_booke.h (100%)
>>>>
>>>> diff --git a/include/asm-ppc/reg_booke.h b/include/asm-powerpc/
>>>> reg_booke.h
>>>> similarity index 100%
>>>> rename from include/asm-ppc/reg_booke.h
>>>> rename to include/asm-powerpc/reg_booke.h
>>>
>>> Could you please change the self inclusion protection defines?
>>
>> Certainement.  I meant to send a second patch to do that, so the
>> first one was *just* a move (who can resist the urge to put out a 0-
>> line patch :).  Will follow up.
>
> I already handled this and duplicated the file in my tree.

Have you cleaned up any of the others?  That was the other reason I  
was going to send a second patch - there are some tsi files, the  
unistd.h file, and a mpc82-something header that also use ASM_PPC -  
we might as well fix that, too.

Cheers,
B
