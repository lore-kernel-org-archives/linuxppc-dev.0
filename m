Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F2E2ADDF4E
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 03:39:26 +1000 (EST)
In-Reply-To: <20071008161927.84C601915AE@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <20071008142554.GA15175@ru.mvista.com>
	<20071008150125.26C802393C7@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<470A55A2.5050606@ru.mvista.com>
	<20071008161927.84C601915AE@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7363E251-62FF-4574-9FF7-8E5719012BAD@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [linux-usb-devel] [PATCH] OHCI: add PowerPC 440EP/440EPx support
Date: Mon, 8 Oct 2007 12:39:34 -0500
To: David Brownell <david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 8, 2007, at 11:19 AM, David Brownell wrote:

>>> Near as I can tell, the original code is wrong ... the hcca- 
>>> >frame_no
>>> byte offset is fully specified, so that shift should always be 16.
>>
>> Are you saying that it should always be #define  
>> OHCI_BE_FRAME_NO_SHIFT
>> 16 for big endian platforms?
>
> More than that, I'm saying that shouldn't even be a #define!  The
> default should be that drivers expect chips to follow the interface
> specs.  Any value other than 16 violates the OHCI spec.
>
> However, based on one other post, I suspect at least one Freescale
> part will need to declare a chip quirk for this case.

Which Freescale part do you think needs this?

- k
