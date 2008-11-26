Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2EF60DDDE0
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Nov 2008 09:37:10 +1100 (EST)
Date: Wed, 26 Nov 2008 14:35:54 -0800 (PST)
From: Trent Piepho <tpiepho@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2] of_gpio: Return GPIO flags from of_get_gpio()
In-Reply-To: <18733.49643.63081.163437@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.64.0811261423120.5161@t2.domain.actdsltmp>
References: <20081030111500.GB22008@oksana.dev.rtsoft.ru>
	<1225418589-8545-1-git-send-email-tpiepho@freescale.com>
	<20081126162033.GA13397@oksana.dev.rtsoft.ru>
	<18733.49643.63081.163437@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 27 Nov 2008, Paul Mackerras wrote:
> Anton Vorontsov writes:
>
>> Can we apply it? Paul, Benjamin?
>>
>> The patchwork url for this patch is:
>> http://patchwork.ozlabs.org/patch/6650/
>>
>>
>> Thanks!
>>
>>>  drivers/mtd/nand/fsl_upm.c              |    2 +-
>>>  drivers/net/fs_enet/fs_enet-main.c      |    2 +-
>>>  drivers/net/phy/mdio-ofgpio.c           |    4 ++--
>>>  drivers/of/gpio.c                       |   13 ++++++++++---
>>>  drivers/serial/cpm_uart/cpm_uart_core.c |    2 +-
>>>  include/linux/of_gpio.h                 |   21 +++++++++++++++++----
>>>  6 files changed, 32 insertions(+), 12 deletions(-)
>
> That would need acks from Jeff Garzik and David Woodhouse.
>
> Alternatively you could add a new function (called, for instance,
> of_get_gpio_flags) with the extra parameter to eliminate the need to
> change any drivers at this stage, since they all seem to pass NULL for
> the flags argument.

But if we did this every time any exported function needs to change, think
how bloated the API would be with cruft.
