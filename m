Return-Path: <dgibson@ozlabs.org>
Date: Mon, 23 Jul 2007 15:30:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] Update kuroboxH[GD].dts with i2c rtc entries, cleanup
Message-ID: <20070723053050.GF3272@localhost.localdomain>
References: <Pine.LNX.4.60.0707220028370.13322@poirot.grange>
	<20070723012602.GA3272@localhost.localdomain>
	<Pine.LNX.4.60.0707230727210.3786@poirot.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.60.0707230727210.3786@poirot.grange>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 23, 2007 at 07:28:12AM +0200, Guennadi Liakhovetski wrote:
> On Mon, 23 Jul 2007, David Gibson wrote:
> 
> > On Sun, Jul 22, 2007 at 12:43:11AM +0200, Guennadi Liakhovetski wrote:
> > [snip]
> > > @@ -64,11 +62,19 @@ build with: "dtc -f -I dts -O dtb -o kuroboxHD.dtb -V 16 kuroboxHD.dts"
> > >  			  fef00000 fef00000 00100000>;	/* pci iack */
> > >  
> > >  		i2c@80003000 {
> > > +			#address-cells = <1>;
> > > +			#size-cells = <0>;
> > >  			device_type = "i2c";
> > >  			compatible = "fsl-i2c";
> > >  			reg = <80003000 1000>;
> > >  			interrupts = <5 2>;
> > >  			interrupt-parent = <&mpic>;
> > > +
> > > +			rtc@32 {
> > > +				device_type = "rtc";
> > > +				compatible = "ricoh,rs5c372b";
> > > +				reg = <32>;
> > 
> > Ok, just making sure that rtc at 0x32 (decimal 50) is correct, rather
> > than at decimal 32.
> 
> Yes, it is. I even tested it:-)

Ok, just making sure, since it's an easy mistake to make.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
