Return-Path: <akonovalov@ru.mvista.com>
Received: from localhost.localdomain (83-102-235-87.broadband.corbina.ru
	[83.102.235.87])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1FC436886F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Nov 2005 21:22:57 +1100 (EST)
Message-ID: <438D7935.20706@ru.mvista.com>
Date: Wed, 30 Nov 2005 13:04:37 +0300
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: "David H. Lynch Jr" <dhlii@comcast.net>
References: <20051125214126.15F9E6884D@ozlabs.org>	<Pine.WNT.4.61.0511291821320.3620@holyoke.labs.mot.com>
	<438D0878.30503@comcast.net>
In-Reply-To: <438D0878.30503@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: T Ziomek <ctz001@email.mot.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Is there some articles discussing how to change bare-board code
 to linux driver?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

David H. Lynch Jr wrote:
> Where can I find the ./drivers/net/xilinx_enet, ... etc files.
> I can not find them in the 2.6.14.2 tree

They are in the linuxppc-2.4 tree. Try
rsync -avz --delete source.mvista.com::linuxppc-2.4 <directory>

-- Andrei

> T Ziomek wrote:
> 
>>>    Where can i find them?thanks.
>>
>>
>> In addition to LDD3 (for 2.6 kernels, or the freely available LDD2 for 
>> 2.4 kernels), you might want to look at some existing Linux drivers 
>> that are
>> based on "bare metal" / "no OS" drivers.  The ones I know of are for 
>> Xilinx
>> peripherals, for example (within the Linux kernel tree),
>> - ./drivers/net/xilinx_enet
>> - ./drivers/char/xilinx_uartlite
>> - ./drivers/char/xilinx_gpio
>>
>> Tom
> 
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
