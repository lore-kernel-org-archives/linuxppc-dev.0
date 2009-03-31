Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 55CD6DDD1C
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 08:48:56 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n2VLmq5o029622
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 14:48:52 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n2VLmp5S000429
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 16:48:52 -0500 (CDT)
Date: Tue, 31 Mar 2009 16:48:51 -0500
From: Scott Wood <scottwood@freescale.com>
To: "Matthew L. Creech" <mlcreech@gmail.com>
Subject: Re: MPC83xx console : no output after handover
Message-ID: <20090331214851.GA20012@ld0162-tx32.am.freescale.net>
References: <5ee96a840903311330y36ed97bet92319da8d118086@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5ee96a840903311330y36ed97bet92319da8d118086@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 31, 2009 at 04:30:26PM -0400, Matthew L. Creech wrote:
> (Sorry if this is a dupe, but I think my first attempt was filtered out)

No, it's a dupe. :-)

> I'm trying to get Linux booting on a custom board based on the MPC8313
> ERDB, but there's no output after the console is transferred.  I get
> the following:
[snip]
> Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> serial8250.0: ttyS0 at MMIO 0xe0004500 (irq = 16) is a 16550A
> console handover: boot [udbg0] -> real [ttyS0]
> serial8250.0: ttyS1 at MMIO 0xe0004600 (irq = 17) is a 16550A

Make sure that u-boot for your board (or whatever you're using) is
properly filling in the clock-frequency property of the serial port
nodes.

-Scott
