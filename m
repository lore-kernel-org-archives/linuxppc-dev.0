Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id 455EA2BDAB
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Oct 2004 05:08:17 +1000 (EST)
Date: Thu, 7 Oct 2004 15:01:24 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Tom Rini <trini@kernel.crashing.org>
In-Reply-To: <20041007184840.GN14773@smtp.west.cox.net>
Message-ID: <Pine.LNX.4.60.0410071459430.7064@dell.enoriver.com>
References: <1096517265.27208.18.camel@localhost.localdomain>
	<20041007154029.GE14773@smtp.west.cox.net>
	<Pine.LNX.4.60.0410071158320.5191@dell.enoriver.com>
	<20041007173023.GK14773@smtp.west.cox.net>
	<Pine.LNX.4.60.0410071354340.6526@dell.enoriver.com>
	<20041007184840.GN14773@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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

On Thu, 7 Oct 2004, Tom Rini wrote:

> On Thu, Oct 07, 2004 at 02:09:05PM -0400, Robert P. J. Day wrote:

>> regarding Kconfig, that currently defines the following config
>> variables related to UARTs (all of the latter ones dependent on the
>> first, so if you delete the first, all the rest pretty well have to
>> vanish as well):
>>
>>   CONFIG_8xx_UART
>>   CONFIG_SMC2_UART
>>   CONFIG_ALTSMC2
>>   CONFIG_CONS_SMC2
>>   CONFIG_USE_SCC_IO
>
> Not all of these options exist in linux-2.6.


actually, that was my point -- once you remove that chunk of the 
Kconfig file, those variables disappear so nothing else in the source 
tree anywhere better depend on any of them.

i'm pretty sure we're agreeing here. :-)

rday
