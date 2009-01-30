Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 744A1DE1EA
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Jan 2009 08:30:32 +1100 (EST)
Subject: Re: Broken PCI on Sequoia
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <1233349323.18767.31.camel@pasglop>
References: <alpine.LRH.2.00.0901291819440.22142@vixen.sonytel.be>
	<1233267061.18767.5.camel@pasglop>
	<20090130001842.GB3943@zod.rchland.ibm.com>
	<1233281333.18767.15.camel@pasglop>
	<alpine.LRH.2.00.0901301334220.13283@vixen.sonytel.be>
	<1233349323.18767.31.camel@pasglop>
Content-Type: text/plain
Date: Sat, 31 Jan 2009 08:30:24 +1100
Message-Id: <1233351024.18767.32.camel@pasglop>
Mime-Version: 1.0
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> For that sort of 4xx PHB (ie, the PCI 2.x ones, not the PCI-X nor the
> PCI-E), we only know how to program 32-bit of PLB address. IE. The old
> code would have cropped the plb_addr when writing to the register, the
> new code complains.
> 
> I suspect some implementation support a register to put the "high" part
> of the PLB address, and that it already contains 1, so the old code
> would have worked by chance, the new code doesn't because it bails out.

Hrm... from the doco it's also one 32-bit register... I'm starting to
think that those guys always assume the top 1 bit is set or something
like that ...

The doc is unclear. Maybe somebody form AMCC can confirm ?

Cheers,
Ben.
