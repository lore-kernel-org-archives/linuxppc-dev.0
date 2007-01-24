Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net
	[151.189.21.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D208EDE0AC
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 09:25:40 +1100 (EST)
In-Reply-To: <1169675091.18754.84.camel@localhost.localdomain>
References: <20061213123819.403286000@sipsolutions.net>
	<20061213123945.386891000@sipsolutions.net>
	<1169620444.18754.66.camel@localhost.localdomain>
	<20070124085420.GA19810@iram.es>
	<1169631177.18754.82.camel@localhost.localdomain>
	<20070124103621.GA22579@iram.es>
	<2435847C-A9FC-4430-A122-416B9B347038@kernel.crashing.org>
	<1169675091.18754.84.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <A030796C-8E88-4F26-A18A-AFA31010B510@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/3] powermac: proper time of day after resume
Date: Wed, 24 Jan 2007 23:24:29 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> The best solution may require informing the user space ntp code of
>>> such events. This requires very likely modifications to ntp itself
>>> (I may be wrong, I've not looked at NTP code for 5 years or so).
>>
>> Doesn't the kernel send signals to init on suspend/resume
>> events, just like with power fail events?  You can hook on
>> that.
>
> I don't think it does... at least not on powerbooks.

<Cpt. Picard voice>  Make it so.

:-)


Segher
