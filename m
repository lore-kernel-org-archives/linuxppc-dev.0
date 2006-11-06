Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx018.isp.belgacom.be (outmx018.isp.belgacom.be
	[195.238.4.117])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D7E4867D07
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Nov 2006 23:35:01 +1100 (EST)
Received: from outmx018.isp.belgacom.be (localhost [127.0.0.1])
	by outmx018.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id kA6CYkRw016839
	for <linuxppc-embedded@ozlabs.org>; Mon, 6 Nov 2006 13:34:46 +0100
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: Adrian Cox <adrian@humboldt.co.uk>
Subject: Re: Flash programming using a BDI2000 on a MPC8248 CPU
Date: Mon, 6 Nov 2006 13:38:28 +0100
References: <200611060942.05419.laurent.pinchart@tbox.biz>
	<200611061316.47705.laurent.pinchart@tbox.biz>
	<1162815970.20962.3.camel@localhost.localdomain>
In-Reply-To: <1162815970.20962.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200611061338.28549.laurent.pinchart@tbox.biz>
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

> > The workspace is in internal RAM, mapped at address 0x00000000 (the
> > hardware reset configuration register is 0x00000000). I tried setting
> > IMMR to 0xf0000000 and mapping the SDRAM at 0x00000000, without success.
> > The BDI2000 reports successfull flash programming, but the flash is
> > definitely empty.
>
> I've also had problems with 8260 family flash programming caused by the
> processor reading the Hard Reset Configuration Word from flash before
> the BDI takes over. Does your board allow you to change RSTCONF to stop
> the processor reading the HRCW?

Yes it does. The HRCW is set to 0x00000000 by deasserting RSTCONF (logic 
high). All tests were made with RSTCONF high (and thus HRCW equal to 
0x00000000).

Laurent Pinchart
