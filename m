Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id F0A8DDDEDA
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Feb 2008 01:07:13 +1100 (EST)
Message-ID: <47AB1023.9040707@ru.mvista.com>
Date: Thu, 07 Feb 2008 17:05:23 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Imre Kaloz <kaloz@openwrt.org>
Subject: Re: [PATCH] MTD support for the AMCC Taishan
References: <120203530465-git-send-email-kaloz@openwrt.org>
	<op.t55gr5lb2s3iss@ecaz.afh.b-m.hu>
	<20080207060012.788e4258@zod.rchland.ibm.com>
	<47AB0BC3.2000202@ru.mvista.com>
	<op.t55p8elk2s3iss@ecaz.afh.b-m.hu>
In-Reply-To: <op.t55p8elk2s3iss@ecaz.afh.b-m.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Imre Kaloz wrote:
> Well, arch/ppc calculates the mtd2 dynamically and doesn't create
> a separate partition for kozio.

That dynamic size calculation depends on the flash size.
The board I use has a 64MB NOR flash (I'm not aware of other Taishan 
boards having chips of different size). So AFAIU if such board exists, 
we'll need a cuboot flash-size fixup.

Thanks,
Valentine.
> 
> I've based this on how it's currently done for the Sequoia, too.
> 
> 
> Imre
> 
> On Thu, 07 Feb 2008 14:46:43 +0100, Valentine Barshak 
> <vbarshak@ru.mvista.com> wrote:
> 
>> Josh Boyer wrote:
>>> On Thu, 07 Feb 2008 11:29:55 +0100
>>> "Imre Kaloz" <kaloz@openwrt.org> wrote:
>>>
>>>> *bump*? :) If anything is wrong with it, please let me know.
>>
>> The arch/ppc had a bit different partition table.
>> Something like this:
>> mtd0: 00180000 00040000 "kernel"
>> mtd1: 00200000 00040000 "root"
>> mtd2: 03bc0000 00040000 "user"
>> mtd3: 00080000 00040000 "env"
>> mtd4: 00040000 00040000 "u-boot"
>>
>> Thanks,
>> Valentine.
>>
>>>  Nothing wrong that I could see.  I just need to test it first.
>>>  josh
>>> _______________________________________________
>>> Linuxppc-dev mailing list
>>> Linuxppc-dev@ozlabs.org
>>> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>>
> 
> 
