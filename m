Return-Path: <marcel@holtmann.org>
Received: from mail.holtmann.org (senator.holtmann.net [87.106.208.187])
	by ozlabs.org (Postfix) with ESMTP id EC554DDFC1
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 11:13:26 +1000 (EST)
Message-Id: <7949EA87-4340-4353-AFC9-79A718B95DF0@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20080727.180736.74131389.davem@davemloft.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v928.1)
Subject: Re: mISDN still breaking the allmodconfig build...
Date: Mon, 28 Jul 2008 03:13:21 +0200
References: <20080727.170235.97056809.davem@davemloft.net>
	<93120C4B-D2F4-4479-806B-2141AC3DC607@holtmann.org>
	<20080727.180736.74131389.davem@davemloft.net>
Cc: sfr@canb.auug.org.au, kkeil@suse.de, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Dave,

>>> More fallout from the premature mISDN driver merge:
>>>
>>> drivers/isdn/hardware/mISDN/hfcmulti.c:5255:2: error: #error "not
>>> running on big endian machines now"
>>
>> is that only the HFC driver or the whole mISDN stack?
>>
>> I know that the two old ISDN stacks where really bad on big endian,
>> but my assumption was that we did sort this out in the end.
>
> One of the two mISDN drivers uses the deprecated virt_to_bus()
> interface for handling DMA addresses (that doesn't even work on many
> x86 systems these days) and the other mISDN driver gives the above
> big-endian compile time error.
>
> In short, this driver was not ready for merging at all.

I am not defending it and agree that this driver should have had at  
least one test run in linux-next. However mISDN is a whole ISDN stack.  
So does mISDN has an issue too or do we only have a really broken  
driver. Karsten?

Regards

Marcel
