Return-Path: <adrian@humboldt.co.uk>
Received: from mail.humboldt.co.uk (mail.humboldt.co.uk [80.68.93.146])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D435067D07
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Nov 2006 23:26:31 +1100 (EST)
Subject: Re: Flash programming using a BDI2000 on a MPC8248 CPU
From: Adrian Cox <adrian@humboldt.co.uk>
To: Laurent Pinchart <laurent.pinchart@tbox.biz>
In-Reply-To: <200611061316.47705.laurent.pinchart@tbox.biz>
References: <200611060942.05419.laurent.pinchart@tbox.biz>
	<1162811478.16089.8.camel@localhost.localdomain>
	<200611061316.47705.laurent.pinchart@tbox.biz>
Content-Type: text/plain
Date: Mon, 06 Nov 2006 12:26:10 +0000
Message-Id: <1162815970.20962.3.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 2006-11-06 at 13:16 +0100, Laurent Pinchart wrote:
> The workspace is in internal RAM, mapped at address 0x00000000 (the hardware 
> reset configuration register is 0x00000000). I tried setting IMMR to 
> 0xf0000000 and mapping the SDRAM at 0x00000000, without success. The BDI2000 
> reports successfull flash programming, but the flash is definitely empty.

I've also had problems with 8260 family flash programming caused by the
processor reading the Hard Reset Configuration Word from flash before
the BDI takes over. Does your board allow you to change RSTCONF to stop
the processor reading the HRCW?

-- 
Adrian Cox <adrian@humboldt.co.uk>
