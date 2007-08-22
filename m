Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EC190DDF36
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 00:59:12 +1000 (EST)
In-Reply-To: <20070822145415.GA22595@localhost.localdomain>
References: <20070821134537.GA7428@localhost.localdomain>
	<20070821152745.GA28986@localhost.localdomain>
	<3DC4D103-C7C1-42CC-AEE6-38CFB8836E82@kernel.crashing.org>
	<20070822145415.GA22595@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1968F4E2-90F9-46A2-ADC2-DEF28F22CCEA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v6 0/2] SPI support for fsl_soc and mpc832x_rdb
Date: Wed, 22 Aug 2007 10:01:13 -0500
To: avorontsov@ru.mvista.com
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 22, 2007, at 9:54 AM, Anton Vorontsov wrote:

> On Wed, Aug 22, 2007 at 09:22:47AM -0500, Kumar Gala wrote:
>>
>> On Aug 21, 2007, at 10:27 AM, Anton Vorontsov wrote:
>>
>>> On Tue, Aug 21, 2007 at 05:45:37PM +0400, Anton Vorontsov wrote:
>>>> Hi all,
>>>>
>>>> Thanks for the previous reviews, this is v4 against Linus' tree,
>>>> as of today.
>>>
>>> Okay, here is brand-new, shiny v5. Today and only today it comes
>>> without section mismatch warnings, don't miss your chance. Get it
>>> free of charge! ;-)
>>
>> This looks good, have some minor cleanup nits.
>
> Much thanks, fixed.

np.  Do you know what effect the modalias being wrong has on current  
functionality?  and when mmc_spi gets added?

- k
