Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C135BDDE22
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Aug 2007 01:53:45 +1000 (EST)
Date: Mon, 13 Aug 2007 10:53:26 -0500
From: Scott Wood <scottwood@freescale.com>
To: "Morrison, Tom" <tmorrison@empirix.com>
Subject: Re: Early UART setup on 2.6 kernel for mpc85xx
Message-ID: <20070813155326.GA17535@ld0162-tx32.am.freescale.net>
References: <mailman.1.1186797602.26064.linuxppc-dev@ozlabs.org>
	<BD261180E6D35F4D9D32F3E44FD3D90108D46267@EMPBEDEX.empirix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BD261180E6D35F4D9D32F3E44FD3D90108D46267@EMPBEDEX.empirix.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 13, 2007 at 07:09:40AM -0400, Morrison, Tom wrote:
> >> In order to debug the kernel 2.6, I want setup serial port with 
> >> UART on mpc85xx as early as possible. I add the register access 
> >> code at the beginning of  platform_init(). For example, I try 
> >> to write THR register(0xe0004500). However the system just 
> >> hanging there with this line.

Make sure there's a mapping in the TLB for that address.

> FWIW, you really can't debug the earliest init code 
> because most of that is in assembly. Get a JTAG emulator
> (BDI or Lauterbach) and start stepping through.

It's quite possible to debug assembly code without JTAG. :-)

-Scott
