Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 7A251DDF06
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 01:13:46 +1000 (EST)
Date: Wed, 22 Aug 2007 19:13:59 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v6 0/2] SPI support for fsl_soc and mpc832x_rdb
Message-ID: <20070822151359.GA23060@localhost.localdomain>
References: <20070821134537.GA7428@localhost.localdomain>
	<20070821152745.GA28986@localhost.localdomain>
	<3DC4D103-C7C1-42CC-AEE6-38CFB8836E82@kernel.crashing.org>
	<20070822145415.GA22595@localhost.localdomain>
	<1968F4E2-90F9-46A2-ADC2-DEF28F22CCEA@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <1968F4E2-90F9-46A2-ADC2-DEF28F22CCEA@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 22, 2007 at 10:01:13AM -0500, Kumar Gala wrote:
>
> On Aug 22, 2007, at 9:54 AM, Anton Vorontsov wrote:
>
>> On Wed, Aug 22, 2007 at 09:22:47AM -0500, Kumar Gala wrote:
>>>
>>> On Aug 21, 2007, at 10:27 AM, Anton Vorontsov wrote:
>>>
>>>> On Tue, Aug 21, 2007 at 05:45:37PM +0400, Anton Vorontsov wrote:
>>>>> Hi all,
>>>>>
>>>>> Thanks for the previous reviews, this is v4 against Linus' tree,
>>>>> as of today.
>>>>
>>>> Okay, here is brand-new, shiny v5. Today and only today it comes
>>>> without section mismatch warnings, don't miss your chance. Get it
>>>> free of charge! ;-)
>>>
>>> This looks good, have some minor cleanup nits.
>>
>> Much thanks, fixed.
>
> np.  Do you know what effect the modalias being wrong has on current 
> functionality?

No effect in the `kernel oops' meanings, nothing too bad will happen.

But personally I vote for spidev stub to stay. This way I (and anybody
else) can actually test SPI (and MMC) even without mmc_spi driver, i.e.
using Documentation/spi/spidev_test.c (already in Linus' tree).

> and when mmc_spi gets added?

Let's hope in v2.6.24. IIRC it's already in -mm for some time, and it's
pretty mature already, thanks to David Brownell.

> - k

Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
