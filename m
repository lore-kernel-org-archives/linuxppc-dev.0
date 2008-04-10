Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 922D7DE324
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 03:41:47 +1000 (EST)
Message-Id: <035F3758-5399-4482-9874-30D737B9B44E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
In-Reply-To: <200804101751.00618.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: How to pass information from the bootloader to the kernel ?
Date: Thu, 10 Apr 2008 12:41:29 -0500
References: <200804101751.00618.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 10, 2008, at 10:50 AM, Laurent Pinchart wrote:
> Hi everybody,
>
> I need to pass a limited amount of information from the boot loader  
> to the
> Linux kernel, such as the boot mode chosen by the user or the last  
> boot
> reason (power up, reset, watchdog, ...).
>
> What is the best way to pass that kind of information from the boot  
> loader to
> the kernel ? Should I use the device tree ?
>
> I thought about populating the chosen node with the data I need.  
> This could
> make sense for the boot mode, but I feel like I would abuse the  
> chosen node
> if I used it to pass other "non user chosen" information.

using chosen is fine, just remember to prefix properties with some  
vendor prefix.

- k
