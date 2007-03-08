Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 9315FDDE25
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Mar 2007 06:03:49 +1100 (EST)
Subject: Re: [RFC 2/3] MPC8544 DTS file
From: Jon Loeliger <jdl@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <0926D082-9EAC-4119-A3F9-F0EF130C606D@kernel.crashing.org>
References: <1173302064.23776.185.camel@ld0161-tx32>
	<0926D082-9EAC-4119-A3F9-F0EF130C606D@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1173380623.23776.208.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Thu, 08 Mar 2007 13:03:43 -0600
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-03-07 at 22:39, Kumar Gala wrote:

> > +/ {
> > +	model = "MPC8544DS";
> > +	compatible = "mpc85xx";
> 
> Been doing the following on other 85xx:
>          compatible = "MPC8540ADS", "MPC85xxADS";
> 
> Not sure if there will be other "DS" boards with 85xx?

I could add that, but I'm not sure if there will be
other 85xx DS boards either.


> > +	memory {
> > +		device_type = "memory";
> > +		reg = <00000000 20000000>;	// 512M at 0x0
> > +	};
> 
> Does the u-boot fill this in?

Uh, yeah, should.  We could leave it 0, rather than 2-bazillion?

> 			interrupts = <
> > +				10 2 11 2 12 2 13 2
> > +				14 2 15 2 16 2 17 2
> > +				18 2 19 2 1a 2 1b 2
> > +				1c 2 1d 2 1e 2 1f 2
> > +				20 2 21 2 22 2 23 2
> > +				24 2 25 2 26 2 27 2
> > +				28 2 29 2 2a 2 2b 2
> > +				2c 2 2d 2 2e 2 2f 2
> > +				30 2 31 2 32 2 33 2
> > +				34 2 35 2 36 2 37 2
> > +				38 2 39 2 2a 2 3b 2
> > +				3c 2 3d 2 3e 2 3f 2
> > +				48 1 49 2 4a 1
> > +			>;
> > +
> > +
> 
> I think this is old and can be removed

Yeah, will do.
 		
jdl
