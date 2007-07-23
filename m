Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id DE3D2DDED1
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 15:28:18 +1000 (EST)
Date: Mon, 23 Jul 2007 07:28:12 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] Update kuroboxH[GD].dts with i2c rtc entries, cleanup
In-Reply-To: <20070723012602.GA3272@localhost.localdomain>
Message-ID: <Pine.LNX.4.60.0707230727210.3786@poirot.grange>
References: <Pine.LNX.4.60.0707220028370.13322@poirot.grange>
	<20070723012602.GA3272@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 23 Jul 2007, David Gibson wrote:

> On Sun, Jul 22, 2007 at 12:43:11AM +0200, Guennadi Liakhovetski wrote:
> [snip]
> > @@ -64,11 +62,19 @@ build with: "dtc -f -I dts -O dtb -o kuroboxHD.dtb -V 16 kuroboxHD.dts"
> >  			  fef00000 fef00000 00100000>;	/* pci iack */
> >  
> >  		i2c@80003000 {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> >  			device_type = "i2c";
> >  			compatible = "fsl-i2c";
> >  			reg = <80003000 1000>;
> >  			interrupts = <5 2>;
> >  			interrupt-parent = <&mpic>;
> > +
> > +			rtc@32 {
> > +				device_type = "rtc";
> > +				compatible = "ricoh,rs5c372b";
> > +				reg = <32>;
> 
> Ok, just making sure that rtc at 0x32 (decimal 50) is correct, rather
> than at decimal 32.

Yes, it is. I even tested it:-)

Thanks
Guennadi
---
Guennadi Liakhovetski
