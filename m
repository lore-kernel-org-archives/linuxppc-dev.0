Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 98B39DE17D
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 11:46:19 +1100 (EST)
Message-Id: <94201A7E-5EFC-49C3-B89F-8630455C583D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
In-Reply-To: <479A0B6E.20507@windriver.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] mpc834x_mds: Convert device tree source to dts-v1
Date: Fri, 25 Jan 2008 10:19:14 -0600
References: <1201242129-13417-1-git-send-email-paul.gortmaker@windriver.com>
	<Pine.LNX.4.64.0801250956380.16736@blarg.am.freescale.net>
	<479A0B6E.20507@windriver.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 25, 2008, at 10:16 AM, Paul Gortmaker wrote:

> Kumar Gala wrote:
>> On Fri, 25 Jan 2008, Paul Gortmaker wrote:
>>
>>
>>> Move mpc834x_mds device tree source forward to dts-v1 format.   
>>> Nothing
>>> too complex in this one, so it boils down to just adding a bunch  
>>> of 0x
>>> in the right places and converting clock speeds to decimal.
>>>
>>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>>> ---
>>> arch/powerpc/boot/dts/mpc834x_mds.dts |  254 ++++++++++++++++ 
>>> +----------------
>>> 1 files changed, 128 insertions(+), 126 deletions(-)
>>>
>>>
>>
>> applied.  I fixed up things so that interrupts use decimal.
>>
>
> Yeah, IRQ was one of those gray areas where I wasn't 100%
> sure whether DTS folks would rather hex or decimal values.

decimal is easier since UMs tend to reference IRQs in dec.

I think on 85xx I might have left them as hex since the IRQs don't  
directly reflect the UMs.

- k
