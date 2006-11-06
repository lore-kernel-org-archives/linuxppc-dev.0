Return-Path: <abdul.rahaman@semindia.in>
Received: from tbird.websitewelcome.com (tbird.websitewelcome.com
	[67.19.210.162])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 69F4367D12
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Nov 2006 23:46:19 +1100 (EST)
Message-ID: <003001c701a1$00757a90$ab80a8c0@xaltedindia.net>
From: "Abdul Rahaman" <abdul.rahaman@semindia.in>
To: "Adrian Cox" <adrian@humboldt.co.uk>,
	"Laurent Pinchart" <laurent.pinchart@tbox.biz>
References: <200611060942.05419.laurent.pinchart@tbox.biz><1162811478.16089.8.camel@localhost.localdomain><200611061316.47705.laurent.pinchart@tbox.biz>
	<1162815970.20962.3.camel@localhost.localdomain>
Subject: Re: Flash programming using a BDI2000 on a MPC8248 CPU
Date: Mon, 6 Nov 2006 18:12:07 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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

You should have RSTCONF pulled UP or LOW.
Use any jumper or something.Only then debugger can take control of target.
But usually once debugger takes control of processor HRCW is not read by
processor(8260).

-Rahaman
----- Original Message ----- 
From: "Adrian Cox" <adrian@humboldt.co.uk>
To: "Laurent Pinchart" <laurent.pinchart@tbox.biz>
Cc: <linuxppc-embedded@ozlabs.org>
Sent: Monday, November 06, 2006 5:56 PM
Subject: Re: Flash programming using a BDI2000 on a MPC8248 CPU


> On Mon, 2006-11-06 at 13:16 +0100, Laurent Pinchart wrote:
> > The workspace is in internal RAM, mapped at address 0x00000000 (the
hardware
> > reset configuration register is 0x00000000). I tried setting IMMR to
> > 0xf0000000 and mapping the SDRAM at 0x00000000, without success. The
BDI2000
> > reports successfull flash programming, but the flash is definitely
empty.
>
> I've also had problems with 8260 family flash programming caused by the
> processor reading the Hard Reset Configuration Word from flash before
> the BDI takes over. Does your board allow you to change RSTCONF to stop
> the processor reading the HRCW?
>
> -- 
> Adrian Cox <adrian@humboldt.co.uk>
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
