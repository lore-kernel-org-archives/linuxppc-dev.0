Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EB6E5DDE03
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 22:48:59 +1000 (EST)
Message-Id: <6A77DF80-0FC5-4025-83BC-2F85CA49BEC2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
In-Reply-To: <200807281042.16872.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [RFC] cpm_uart: Add generic clock API support to set baudrates
Date: Mon, 28 Jul 2008 07:48:53 -0500
References: <200807241405.21770.laurentp@cse-semaphore.com>
	<01409579-8A92-4A16-9C66-7C751BB348E7@kernel.crashing.org>
	<200807281042.16872.laurentp@cse-semaphore.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 28, 2008, at 3:42 AM, Laurent Pinchart wrote:

> This patch introduces baudrate setting support via the generic clock  
> API.
> When present the optional device tree clock property is used instead  
> of
> fsl-cpm-brg. Platforms can then define complex clock schemes, to  
> output
> the serial clock on an external pin for instance.
>
> Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
> ---
> drivers/serial/cpm_uart/cpm_uart.h      |    1 +
> drivers/serial/cpm_uart/cpm_uart_core.c |   26 ++++++++++++++++++ 
> +-------
> 2 files changed, 20 insertions(+), 7 deletions(-)
>
> On Friday 25 July 2008, Kumar Gala wrote:
>> I'm having problems applying due to mailer formatting.
>
> *sigh* I'll definitely have to fix GPG support in kmail. Sorry about  
> the
> annoyance.

np.

applied.

- k
