Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B8A72DDECD
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Jun 2007 10:01:55 +1000 (EST)
Subject: Re: [PATCH 2/8] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <12ad593bd17f769e44f05bc24eac4d0a@kernel.crashing.org>
References: <1180720112.14219.62.camel@ld0161-tx32>
	<dfc15991e31bfc09389461dc443acd7c@kernel.crashing.org>
	<1180734314.5674.49.camel@rhino>
	<4fb92a9dfccf515bdc1522d08f10f823@kernel.crashing.org>
	<20070602085359.GA10333@iram.es>
	<3ebd6ca6877ea74925f066ff96ac81db@kernel.crashing.org>
	<20070602195308.GA21618@iram.es>
	<12ad593bd17f769e44f05bc24eac4d0a@kernel.crashing.org>
Content-Type: text/plain
Date: Sun, 03 Jun 2007 10:01:47 +1000
Message-Id: <1180828907.14025.37.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2007-06-02 at 22:23 +0200, Segher Boessenkool wrote:
> 
> 
> Oh what the hell, I'm too curious...  "pnpPNP,0" it is.
> 
> > I believe that "8259" should appear somewhere because of the
> > "8259-interrupt-acknowledge" property (defined in CHRP bindings)
> > which you can have on the parent bridge to speed up interrupt
> > vector acquisition.
> 
> You're not CHRP so you have nothing to do with the CHRP
> bindings...

Still, you are close to CHRP and the CHRP bindings do apply :-) the 8259
should thus be chrp,iic :-) It's even documented that way in
booting-without-of.txt iirc.

Ben.
