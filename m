Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 3C2B0DDF8F
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 03:43:40 +1000 (EST)
Message-ID: <470A6C07.3020805@ru.mvista.com>
Date: Mon, 08 Oct 2007 21:42:31 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [linux-usb-devel] [PATCH] OHCI: add PowerPC 440EP/440EPx support
References: <20071008142554.GA15175@ru.mvista.com>
	<20071008150125.26C802393C7@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<470A55A2.5050606@ru.mvista.com>
	<20071008161927.84C601915AE@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<7363E251-62FF-4574-9FF7-8E5719012BAD@kernel.crashing.org>
In-Reply-To: <7363E251-62FF-4574-9FF7-8E5719012BAD@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org,
	linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> On Oct 8, 2007, at 11:19 AM, David Brownell wrote:
> 
>>>> Near as I can tell, the original code is wrong ... the hcca->frame_no
>>>> byte offset is fully specified, so that shift should always be 16.
>>>
>>> Are you saying that it should always be #define OHCI_BE_FRAME_NO_SHIFT
>>> 16 for big endian platforms?
>>
>> More than that, I'm saying that shouldn't even be a #define!  The
>> default should be that drivers expect chips to follow the interface
>> specs.  Any value other than 16 violates the OHCI spec.
>>
>> However, based on one other post, I suspect at least one Freescale
>> part will need to declare a chip quirk for this case.
> 
> Which Freescale part do you think needs this?
> 
> - k

I've looked at drivers/usb/host/Kconfig
It seems to be MPC52xx.
David, is that the one you mentioned?
Thanks,
Valentine.
