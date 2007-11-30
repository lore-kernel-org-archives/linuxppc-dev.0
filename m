Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 70A3DDDE1C
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 01:48:30 +1100 (EST)
Message-Id: <0494FF60-0E7E-4315-816F-716CC3C2EF04@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Li Yang <leoli@freescale.com>
In-Reply-To: <989B956029373F45A0B8AF029708189001A1CE7B@zch01exm26.fsl.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH v7 7/9] ipic: clean up unsupported ack operations
Date: Fri, 30 Nov 2007 08:48:23 -0600
References: <1192793930-26039-1-git-send-email-leoli@freescale.com>
	<1192793930-26039-2-git-send-email-leoli@freescale.com>
	<1192793930-26039-3-git-send-email-leoli@freescale.com>
	<1192793930-26039-4-git-send-email-leoli@freescale.com>
	<1192793930-26039-5-git-send-email-leoli@freescale.com>
	<1192793930-26039-6-git-send-email-leoli@freescale.com>
	<1192793930-26039-7-git-send-email-leoli@freescale.com>
	<1192793930-26039-8-git-send-email-leoli@freescale.com>
	<0BCAE755-0506-405D-BFCA-94C2261CBE30@kernel.crashing.org>
	<989B956029373F45A0B8AF029708189001A1CE7B@zch01exm26.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 30, 2007, at 4:03 AM, Li Yang wrote:

>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>> Sent: Friday, November 30, 2007 8:36 AM
>> To: Li Yang
>> Cc: linuxppc-dev@ozlabs.org
>> Subject: Re: [PATCH v7 7/9] ipic: clean up unsupported ack operations
>>
>>
>> On Oct 19, 2007, at 6:38 AM, Li Yang wrote:
>>
>>> IPIC controller doesn't support ack operations.  The
>> pending registers
>>> are read-only.  The patch removes ack operations which are
>> not needed.
>>>
>>> Signed-off-by: Li Yang <leoli@freescale.com>
>>> ---
>>> arch/powerpc/sysdev/ipic.c |   40 +
>>> +--------------------------------------
>>> 1 files changed, 2 insertions(+), 38 deletions(-)
>>
>> applied.
>
> Hi Kumar,
>
> Please hold on this one.  Actually external interrupts in edge mode  
> need
> this ack operation.  But in most cases (level triggered) ack is not
> needed.  I will provide an updated patch later on to take care both
> trigger modes.  Thanks.

Ok, I'll drop this patch.

- k
