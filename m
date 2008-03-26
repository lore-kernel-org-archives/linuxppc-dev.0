Return-Path: <Sergej.Stepanov@ids.de>
Received: from ares.ids.de (ares.ids.de [213.144.29.131])
	by ozlabs.org (Postfix) with ESMTP id 0EA60DDF7C
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 19:31:56 +1100 (EST)
Received: from ares.ids.de (ares.ids.de [127.0.0.1])
	by ares.ids.de (PGP Universal) with ESMTP id 57942F491BF
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 09:31:54 +0100 (CET)
Subject: Re: [PATCH] cpm_uart: Allocate DPRAM memory for SMC ports
	onCPM2-based platforms.
From: Sergej Stepanov <Sergej.Stepanov@ids.de>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
In-Reply-To: <200803251732.32569.laurentp@cse-semaphore.com>
References: <20080325160331.GB15093@ld0162-tx32.am.freescale.net>
	<200803251720.24667.laurentp@cse-semaphore.com>
	<DCEAAC0833DD314AB0B58112AD99B93B04276FB4@ismail.innsys.innovsys.com>
	<200803251732.32569.laurentp@cse-semaphore.com>
Date: Wed, 26 Mar 2008 09:31:53 +0100
Message-Id: <1206520313.26613.14.camel@p60365-ste>
Mime-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Am Dienstag, den 25.03.2008, 17:32 +0100 schrieb Laurent Pinchart:

> Do you have any opinion about the proposed patch ?
> 

I have to say, it could be some off-topic.
But if you would use the cpm_uart-driver for cpm2(or cpm1) as kernel
module, at linking you can get warnings about:
	- cpm_setbrg (cpm_set_brg): something with section mismatch
	-  __alloc_bootmem (cpm_uart_allocbuf): the same

The symbols are not exported.
Is it ok, about kernel modules?

Sergej.
