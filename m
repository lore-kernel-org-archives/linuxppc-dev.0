Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7CD3E2BDB3
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Oct 2004 07:35:21 +1000 (EST)
In-Reply-To: <20041007184840.GN14773@smtp.west.cox.net>
References: <1096517265.27208.18.camel@localhost.localdomain>
	<20041007154029.GE14773@smtp.west.cox.net>
	<Pine.LNX.4.60.0410071158320.5191@dell.enoriver.com>
	<20041007173023.GK14773@smtp.west.cox.net>
	<Pine.LNX.4.60.0410071354340.6526@dell.enoriver.com>
	<20041007184840.GN14773@smtp.west.cox.net>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0927BD6D-18A9-11D9-9049-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 7 Oct 2004 17:37:06 -0400
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] remove obsolete arch/ppc/8xx_io/uart.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Oct 7, 2004, at 2:48 PM, Tom Rini wrote:

>>   CONFIG_8xx_UART
>>   CONFIG_SMC2_UART
>>   CONFIG_ALTSMC2
>>   CONFIG_CONS_SMC2
>>   CONFIG_USE_SCC_IO
>
> Not all of these options exist in linux-2.6.

Why not?  They must or some equivalent to get these features.
I dislike this 2.6 "forward progress" that continually removes
features we have deemed necessary in previous kernel versions.

> I think this had been discussed before, but perhaps not.  What should
> happen at some point is something more like "Do you hae SMC1 ? What is
> it? Do you have SMC2 ? What is it? Do youhave SCC1? What is it?" and so
> on.  For now, I wouldn't worry about it.

I don't understand the "what is it?" part of these questions.  As I
have continually pointed out over the years, we don't have "SMC" or
"SCC" drivers.  We have UART drivers that use SMCs or SCC, Ethernet
drivers that use SCCs or FECs, audio drivers that use SMCs or SCCs,
and so on.  It's a subtle but important configuration selection.  You
select the feature you want (uart, Ethernet, audio, ATM, etc.), then
you can be further prompted for peripheral routing information if 
necessary.
We have discussed this at length in the past.

Thanks.


	-- Dan
