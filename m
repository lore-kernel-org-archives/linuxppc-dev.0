Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3C8CBDE263
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 03:39:48 +1000 (EST)
Message-Id: <01409579-8A92-4A16-9C66-7C751BB348E7@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
In-Reply-To: <200807241405.21770.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [RFC] cpm_uart: Add generic clock API support to set baudrates
Date: Fri, 25 Jul 2008 12:39:36 -0500
References: <200807241405.21770.laurentp@cse-semaphore.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 24, 2008, at 7:05 AM, Laurent Pinchart wrote:

> This patch introduces baudrate setting support via the generic clock  
> API.
> When present the optional device tree clock property is used instead  
> of
> fsl-cpm-brg. Platforms can then define complex clock schemes, to  
> output
> the serial clock on an external pin for instance.
>
> This is required to support RS485 ports on a platform I'm working on  
> (TBox
> CPU32 - see http://www.cse-semaphore.com/products/t-box/t-box-ms.php).
>
> ---
> drivers/serial/cpm_uart/cpm_uart.h      |    1 +
> drivers/serial/cpm_uart/cpm_uart_core.c |   26 ++++++++++++++++++ 
> +-------
> 2 files changed, 20 insertions(+), 7 deletions(-)

I'm having problems applying due to mailer formatting.

- k
