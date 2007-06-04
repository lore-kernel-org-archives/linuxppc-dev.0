Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6B412DDDF4
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Jun 2007 04:49:35 +1000 (EST)
Subject: Re: [PATCH 2/8] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
From: Jon Loeliger <jdl@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1180828253.14025.22.camel@localhost.localdomain>
References: <1180720112.14219.62.camel@ld0161-tx32>
	<1180828253.14025.22.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1180982967.9632.20.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Mon, 04 Jun 2007 13:49:27 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2007-06-02 at 18:50, Benjamin Herrenschmidt wrote:
> Minor nits (in addition to needing a "reg" property)
> 
> > +
> > +						i8259: i8259@4d0 {
> 
> Name should probably be "interrupt-controller" as well to follow the
> recommended naming practice.
> 
> > +							clock-frequency = <0>;
> > +							interrupt-controller;
> > +							device_type = "interrupt-controller";
> > +							#address-cells = <0>;
> > +							#interrupt-cells = <2>;
> > +							built-in;
> > +							compatible = "chrp,iic";
> > +							big-endian;
> 
> big-endian ? On a 8259 ? 
> 
> > +							interrupts = <49 2>;
> > +							interrupt-parent =
> > +								<&mpic>;
> > +						};
> > +					};
> > +				};
> >  			};
> >  
> >  		};
> 

Since the interrupt controller issues are a bit unrelated
to the PCI-Express enablement patches here, I'll submit a
follow-up patch set to clean them up.

Thanks,
jdl
