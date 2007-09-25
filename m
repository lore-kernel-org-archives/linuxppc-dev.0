Return-Path: <dgibson@ozlabs.org>
Date: Tue, 25 Sep 2007 12:04:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [patch 3/3] mpc8349emitx.dts: Add ds1339 RTC
Message-ID: <20070925020459.GE30338@localhost.localdomain>
References: <20070920104211.896143373@sunsite.dk>
	<20070920104313.217207466@sunsite.dk>
	<20070920133528.GC14820@ld0162-tx32.am.freescale.net>
	<874pholbdk.fsf@macbook.be.48ers.dk>
	<20070924050709.GM8058@localhost.localdomain>
	<46F7CF2F.9070805@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46F7CF2F.9070805@freescale.com>
Cc: Timur Tabi <timur@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 24, 2007 at 09:52:31AM -0500, Scott Wood wrote:
> David Gibson wrote:
> >>  		i2c@3100 {
> >> +			#address-cells = <1>;
> >> +			#size-cells = <0>;
> >>  			device_type = "i2c";
> > 
> > Hrm... we probably want an "i2c" device_type class, but I don't think
> > we've actually defined one, which is a problem
> 
> Right... but we need to get the kernel to stop expecting the device type 
> to be there before we yell at people for including it. :-)

Obviously.  We should make sure all the corresponding compatibles are
specific enough, change the drivers, then think about getting rid of
it.

> > The fact that NVRAM+RTC chips are so common is a bit of an issue from
> > the point of view of defining a device class binding - a device can't
> > have type "rtc" and "nvram".
> 
> This is one of the reasons that I'd prefer to use compatible for such 
> things.

Yeah, fair enough.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
