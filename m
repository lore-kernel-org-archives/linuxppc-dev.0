Return-Path: <jonmasters@gmail.com>
Received: from mproxy.gmail.com (rproxy.gmail.com [64.233.170.205])
	by ozlabs.org (Postfix) with ESMTP id 1B7732BDB5
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Sep 2004 23:43:32 +1000 (EST)
Received: by mproxy.gmail.com with SMTP id 75so1632848rnl
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Sep 2004 06:43:31 -0700 (PDT)
Message-ID: <35fb2e5904092306432186f4d@mail.gmail.com>
Date: Thu, 23 Sep 2004 14:43:30 +0100
From: Jon Masters <jonmasters@gmail.com>
To: Jeff Angielski <jeff@theptrgroup.com>
In-Reply-To: <1095946560.13705.7.camel@nighteyes.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <35fb2e5904090607241087442d@mail.gmail.com>
	<35fb2e59040919131864c26952@mail.gmail.com>
	<35fb2e59040922181249d18af6@mail.gmail.com>
	<1095946560.13705.7.camel@nighteyes.localdomain>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] xsa_use_interrupts flag [WAS: xilinx_sysace]
Reply-To: jonathan@jonmasters.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 23 Sep 2004 09:36:00 -0400, Jeff Angielski <jeff@theptrgroup.com> wrote:

> We are using the SystemACE on our custom MPC8260 platform and I do not
> recall seeing extra interrupts on the sector writes.

This is on a Virtex II Pro which does not use the interrupt controller
that you mention. I'm quite sure *some* people are able to use this
just fine - otherwise there wouldn't be interrupt driven IO in the
Monta driver, but it doesn't work on all boards, and it's not a simple
bug in the interrupt handling code - it's a real extra unwanted
interrupt from the chip.

The board in question is the Memec one with lots of custom logic, the
xintc and a bunch of other bits running 2.4.23 but without any of the
HAL nonesense and Xilinx xparameters stuff.

Cheers,

Jon.
