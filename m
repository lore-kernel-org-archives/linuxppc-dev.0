Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 05460DDED8
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 04:01:18 +1100 (EST)
Message-Id: <8CFD0641-F9CD-4961-A1B3-C702E8E5DFB7@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20081203192743.GC13035@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 3/5] powerpc/83xx: Add USB Host/Gadget support for
	MPC8360E-MDS boards
Date: Wed, 17 Dec 2008 10:59:09 -0600
References: <20081203192644.GA6145@oksana.dev.rtsoft.ru>
	<20081203192743.GC13035@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 3, 2008, at 1:27 PM, Anton Vorontsov wrote:

> - Update the device tree per QE USB bindings;
> - Add timer (FSL GTM) node;
> - Add gpio-controller node for BCSR13 bank (GPIOs on that bank
>  are used to control the USB transceiver);
> - Set up other BCSR registers;
> - Configure the QE Par IO.

Of these are they all in the kernel tree already?  What I mean is QE  
usb bindings in linus's tree?  I know GTM timers is and this patch  
series had the bcsr gpio.  Similar question for qe par io.  I think we  
are good but clearly I leave much of QE to you & timur.

- k
