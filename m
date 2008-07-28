Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2FCFBDE32A
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 22:49:06 +1000 (EST)
Message-Id: <9F89A79B-5BF3-422D-8C3C-6C22F75A4A1A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
In-Reply-To: <200807241836.37913.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCHv2] cpm_uart: Modem control lines support
Date: Mon, 28 Jul 2008 07:49:01 -0500
References: <200804161110.21778.laurentp@cse-semaphore.com>
	<200807241705.03340.laurentp@cse-semaphore.com>
	<2F3F000A-AC69-4C15-A535-F93B60BA191E@kernel.crashing.org>
	<200807241836.37913.laurentp@cse-semaphore.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 24, 2008, at 11:36 AM, Laurent Pinchart wrote:

> This patch replaces the get_mctrl/set_mctrl stubs with modem control  
> line
> read/write access through the GPIO lib.
>
> Available modem control lines are described in the device tree using  
> GPIO
> bindings. The driver expect a GPIO pin for each of the CTS, RTS,  
> DCD, DSR,
> DTR and RI signals. Unused control lines can be left out.
>
> Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
> ---
> Documentation/powerpc/booting-without-of.txt |   10 ++++++
> drivers/serial/cpm_uart/cpm_uart.h           |   10 ++++++
> drivers/serial/cpm_uart/cpm_uart_core.c      |   40 +++++++++++++++++ 
> +++++++--
> 3 files changed, 57 insertions(+), 3 deletions(-)

applied.

- k
