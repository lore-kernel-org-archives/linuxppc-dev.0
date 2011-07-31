Return-Path: <felix@embedded-sol.com>
Received: from sh78.surpasshosting.com (sh78.surpasshosting.com [72.29.64.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E6C91B6F8C
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Aug 2011 00:56:42 +1000 (EST)
Message-ID: <4E356D28.3010309@embedded-sol.com>
Date: Sun, 31 Jul 2011 17:56:40 +0300
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: GPIO IRQ on P1022
References: <4E35309E.4000202@embedded-sol.com>
	<4E355FB7.3030904@freescale.com>
In-Reply-To: <4E355FB7.3030904@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Timur,

On 07/31/2011 04:59 PM, Tabi Timur-B04825 wrote:
> Felix Radensky wrote:
>>       What happens when I load my driver is single execution of interrupt
>> handler
>>       followed by system freeze. Even if I call disable_irq() in interrupt
>> handler the
>>       system still freezes.
> I don't know anything about the GPIO layer, but I think you're going to
> need to debug this a little more.  Where exactly is the freeze?  Are you
> sure the interrupt handler is being called only once?  Perhaps you're not
> clearing the interrupt status and your handler is being called repeatedly?
>

It was verified with oscilloscope that interrupt handler clears the
interrupt. The interrupt line goes from low to high and stays there.
I have prints in interrupt handler, they appear only once.

It's difficult to say where it freezes. I've tried magic sysrq on serial
console, but got nothing.


Felix.
