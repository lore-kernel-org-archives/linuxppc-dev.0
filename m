Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AF3FFDDE04
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 02:32:26 +1100 (EST)
Message-Id: <33A3857D-9829-40CA-9A8E-751C2C417E5E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20080211130132.GA6445@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH v4] [POWERPC] MPC8360E-RDK: device tree,
	board file and defconfig
Date: Mon, 11 Feb 2008 09:32:20 -0600
References: <20080201135640.GA10966@localhost.localdomain>
	<20080211130132.GA6445@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 11, 2008, at 7:01 AM, Anton Vorontsov wrote:

> On Fri, Feb 01, 2008 at 04:56:40PM +0300, Anton Vorontsov wrote:
>> This is new board made by Freescale Semiconductor Inc. and
>> Logic Product Development.
>>
>> Currently supported:
>> 1. UEC{1,2,7,4};
>> 2. I2C;
>> 3. SPI;
>> 4. NS16550 serial;
>> 5. PCI and miniPCI;
>> 6. Intel NOR StrataFlash X16 64Mbit PC28F640P30T85;
>> 7. Graphics controller, Fujitsu MB86277.
>>
>> Not supported so far:
>> 1. StMICRO NAND512W3A2BN6E, 512 Mbit (supported with FSL UPM  
>> patches);
>> 2. QE Serial UCCs (tested to not work with ucc_uart driver, reason
>>   unknown, yet);
>> 3. ADC AD7843 (tested to work, but support via device tree depends on
>>   major SPI rework, GPIO API, etc);
>> 4. FHCI USB (will send RFC patches soon).
>>
>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>> ---
>>
>> Hello Kumar,
>>
>> It would be great if we can get this into the 2.6.25.
>
> Is there any chance this will hit 2.6.25?..

Not really.  It seemed like there were a lot of other patches this  
really depend on getting so I was waiting to see how that fell out.   
As Linus, just released 2.6.25-rc1 lets queue this up for 2.6.26.

- k
