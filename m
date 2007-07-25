Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id EAB59DDE9A
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 04:17:11 +1000 (EST)
Message-ID: <46A7941F.2050300@ru.mvista.com>
Date: Wed, 25 Jul 2007 22:19:11 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] [POWERPC] MPC8349E-mITX: use platform IDE driver
	for CF	interface
References: <20070725165318.5331.23795.stgit@localhost.localdomain>
	<20070725165326.5331.19920.stgit@localhost.localdomain>
	<46A78322.3080607@ru.mvista.com> <46A78E3F.1030904@ru.mvista.com>
	<20070725180145.GA29689@ld0162-tx32.am.freescale.net>
In-Reply-To: <20070725180145.GA29689@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Scott Wood wrote:

>>    Also, what mmio-ide in the compat properly means in the context of 
>>ide_platform which is able to handle both port and memory mapped IDE.

> I/O-space is only valid in the context of PCI, ISA, or similar buses, and
> the bus-specific reg format indicates whether it's mmio-space or
> io-space.

    You could save time on lecturing me (and use it to look on the driver ;-).

>>I think we must get rid with this crap, and since this IDE register
>>mapping is pretty much board specific, call it something like
>>"mpc8349emitx-ide" instead.

> What is board specific about a set of standard IDE registers at a given

    The regisrer mapping used is highly non-standard.

> address?  Do we need to make board-specific glue code for all of the

    We're already in board specific code, so why the heck not? :-)

> various ns16550-compatibles out there as well?

    I never suggested that -- what I did suggest was make of_serial.c 
recognize certain chip types and register them with 8250 driver.

> -Scott

MBR, Sergei
