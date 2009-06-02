Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B7D8DDDDF0
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Jun 2009 10:50:46 +1000 (EST)
Subject: Re: MPC8272- Porting HDLC driver from 2.6.14 to 2.6.27-
	"no_irq_chip" error
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Frank =?ISO-8859-1?Q?Svendsb=F8e?= <frank.svendsboe@gmail.com>
In-Reply-To: <1ba63b520905301322n72fa165ds7e2eb3af4475f109@mail.gmail.com>
References: <547eba1b0905280037j3336d0av7cc5d4069622d8f4@mail.gmail.com>
	<4A1E6877.2060106@aimvalley.nl> <20090528123311.GA3112@pengutronix.de>
	<1ba63b520905290356l5d519e64w3bd852d8fc4032be@mail.gmail.com>
	<20090529171835.GB22066@b07421-ec1.am.freescale.net>
	<1ba63b520905301322n72fa165ds7e2eb3af4475f109@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 02 Jun 2009 10:48:34 +1000
Message-Id: <1243903714.591.20.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Daniel Ng <daniel.ng1234@gmail.com>,
	Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2009-05-30 at 22:22 +0200, Frank Svendsbøe wrote:
> Regarding doing manual mapping: Is there another way to retrieve the
> host controller
> from a driver module without modifying kernel source? In case not, do
> you think
> exporting the mpc8xx_pic_host symbol is a better solution?
> 
> Anyway, now that I'm beginning to understand dts I guess I might as
> well just do it properly.

Well, precisely :-) The DTS allows to contain the linkage to the PIC and
let the kernel resolve it all nicely for you.

Cheers,
Ben.
