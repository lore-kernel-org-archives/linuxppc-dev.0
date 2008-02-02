Return-Path: <bodonoghue@codehermit.ie>
Received: from lugano.hostireland.com (lugano.hostireland.com [67.192.77.34])
	by ozlabs.org (Postfix) with ESMTP id B3F2ADDF12
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Feb 2008 22:37:02 +1100 (EST)
Subject: Re: PATCH[1/1] 8xx: Add clock-frequency to Adder875 and mpc885ads
	board ports
From: Bryan O'Donoghue <bodonoghue@codehermit.ie>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <47A38888.1010901@freescale.com>
References: <1201736088.3466.3.camel@neuromancer.mindspace>
	<47A38888.1010901@freescale.com>
Content-Type: text/plain
Date: Sat, 02 Feb 2008 11:36:59 +0000
Message-Id: <1201952219.3645.4.camel@neuromancer.mindspace>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-02-01 at 15:00 -0600, Scott Wood wrote:
> Bryan O'Donoghue wrote:
> > Redo the addition of the clock-frequency parameter to the Adder875 .dts
> > so that the values are decimal rather then hex.
> > 
> > 
> > Signed-off-by: Bryan O'Donoghue <bodonoghue@codehermit.ie>
> > ---
> > 
> > diff --git a/arch/powerpc/boot/dts/adder875-redboot.dts
> > b/arch/powerpc/boot/dts/adder875-redboot.dts
> > index 7c25d96..c508f3c 100644
> > --- a/arch/powerpc/boot/dts/adder875-redboot.dts
> > +++ b/arch/powerpc/boot/dts/adder875-redboot.dts
> > @@ -149,6 +149,7 @@
> >                                 compatible = "fsl,mpc875-brg",
> >                                              "fsl,cpm1-brg",
> >                                              "fsl,cpm-brg";
> > +                               clock-frequency = <50000000>;
> >                                 reg = <0x9f0 0x10>;
> >                         };

Actually I was wondering myself why the file was using whitespace
instead of tabs - no doubt something to do with copying between
evolution + gedit.

Will fix this up with vim
