Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id B7978DDE4A
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Dec 2007 02:33:33 +1100 (EST)
Date: Wed, 5 Dec 2007 18:37:27 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH v2 1/4] [libata] pata_platform: make probe and remove
	functions device type neutral
Message-ID: <20071205153727.GA27896@localhost.localdomain>
References: <20071204170442.GA10460@localhost.localdomain>
	<20071204170625.GA15599@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071204170625.GA15599@localhost.localdomain>
Cc: Olof Johansson <olof@lixom.net>, Paul Mundt <lethal@linux-sh.org>,
	Arnd Bergmann <arnd@arndb.de>, Jeff Garzik <jeff@garzik.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 04, 2007 at 08:06:25PM +0300, Anton Vorontsov wrote:
> Split pata_platform_{probe,remove} into two pieces:
> 1. pata_platform_{probe,remove} -- platform_device-dependant bits;
> 2. __ptata_platform_{probe,remove} -- device type neutral bits.
> 
> This is done to not duplicate code for the OF-platform driver.

Paul, do you have any objections regarding that one?

If there is no objections, could you stamp Acked-by on it?
Thus I can resend this set one more time for the merge, w/o
fourth patch.

>  /**
> - *	pata_platform_probe		-	attach a platform interface
> - *	@pdev: platform device
> + *	__pata_platform_probe		-	attach a platform interface
> + *	@dev: device
> + *	@io_res: Resource representing I/O base
> + *	@ctl_res: Resource representing CTL base
> + *	@irq_res: Resource representing IRQ and its flags
> + *	@ioport_shift: I/O port shift
  + *	@__pio_mask: PIO mask

^^^ added

Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
