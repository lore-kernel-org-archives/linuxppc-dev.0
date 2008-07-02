Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0E104DE06C
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 02:13:58 +1000 (EST)
Message-Id: <FF9F9674-03B4-4FD1-9B01-8DC0972F6899@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
In-Reply-To: <200807021058.45619.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCHv2] cpm_uart: Support uart_wait_until_sent()
Date: Wed, 2 Jul 2008 11:13:52 -0500
References: <200806261355.09334.laurentp@cse-semaphore.com>
	<4768A00D-3C8B-4AF2-A2E1-DE9C9BD055E4@kernel.crashing.org>
	<200807021058.45619.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org, linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 2, 2008, at 3:58 AM, Laurent Pinchart wrote:

> Set port->fifosize to the software FIFO size, and update the port  
> timeout
> when the baud rate is modified. SCC ports have an optional 32 byte  
> hardware
> FIFO which is currently not taken into account, as there is no  
> documented way
> to check when the FIFO becomes empty.
>
> Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
> ---
> drivers/serial/cpm_uart/cpm_uart_core.c |    6 ++++++
> 1 files changed, 6 insertions(+), 0 deletions(-)

applied.

- k
