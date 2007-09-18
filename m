Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A9F44DDE38
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 00:02:06 +1000 (EST)
In-Reply-To: <989B956029373F45A0B8AF029708189001763D1E@zch01exm26.fsl.freescale.net>
References: <20070912112456.GA15556@localhost.localdomain><20070913152333.GA2381@localhost.localdomain>
	<C844988E-F6B9-44B9-AB78-C44E19A2E605@kernel.crashing.org>
	<989B956029373F45A0B8AF029708189001763D1E@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <E0E78DB4-3A30-4D2D-83EE-B63D6C3A1D53@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] ucc_geth: fix compilation
Date: Tue, 18 Sep 2007 09:04:04 -0500
To: "Li Yang-r58472" <LeoLi@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Jeff Garzik <jeff@garzik.org>,
	netdev <netdev@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 18, 2007, at 3:56 AM, Li Yang-r58472 wrote:

>> -----Original Message-----
>> From: linuxppc-dev-bounces+leoli=freescale.com@ozlabs.org
>> [mailto:linuxppc-dev-bounces+leoli=freescale.com@ozlabs.org]
>> On Behalf Of Kumar Gala
>> Sent: Friday, September 14, 2007 10:08 PM
>> To: Jeff Garzik
>> Cc: linuxppc-dev@ozlabs.org list; netdev
>> Subject: Re: [PATCH] ucc_geth: fix compilation
>>
>>
>> On Sep 13, 2007, at 10:23 AM, Anton Vorontsov wrote:
>>
>>> Currently qe_bd_t is used in the macro call --
>> dma_unmap_single, which
>>> is a no-op on PPC32, thus error is hidden today. Starting
>> with 2.6.24,
>>> macro will be replaced by the empty static function, and
>> erroneous use
>>> of qe_bd_t will trigger compilation error.
>>>
>>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>>> ---
>>
>> Jeff, I'm going to pick this up via the powerpc.git tree
>> since its currently only broken in our for-2.6.24 branch
>> (because of other changes in there).  Any issues?
>
> Kumar,
>
> Kim Phillips has posted the same patch to netdev list before Anton.
> Therefore, I do prefer to use his.  Thanks

No problem.  Jeff seems to have picked up some version of the fix.

- k
