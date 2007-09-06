Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 42554DDF1E
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 05:56:29 +1000 (EST)
Date: Thu, 6 Sep 2007 14:56:14 -0500
From: Scott Wood <scottwood@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 8/9] 8xx: Adder 875 support
Message-ID: <20070906195614.GA23333@ld0162-tx32.am.freescale.net>
References: <20070905192820.GG32398@ld0162-tx32.am.freescale.net>
	<85281ec227e35a9e466e68e3fdc7e6ef@kernel.crashing.org>
	<20070906141620.GB16353@ld0162-tx32.am.freescale.net>
	<f26578467468e38345e795ea5f1f7c42@kernel.crashing.org>
	<20070906180922.GA18750@ld0162-tx32.am.freescale.net>
	<598e0baf0dc1ca63b91f2a80ec8abe19@kernel.crashing.org>
	<20070906191255.GA22663@ld0162-tx32.am.freescale.net>
	<20070906192025.GA22775@ld0162-tx32.am.freescale.net>
	<43ad9218d498e2d01922a57ebfee2327@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <43ad9218d498e2d01922a57ebfee2327@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 06, 2007 at 09:36:07PM +0200, Segher Boessenkool wrote:
> >BTW, IEEE1275 seems to disagree:
> 
> No it doesn't.

"...in conventional usage the string begins with the name of the device's
manufacturer".  Even if you want to quibble about the manner in which the
manufacturer is specified, that's quite different from leaving it out.

> >  A manufacturer-dependent string that generally specifies the model 
> >name
> >  and number (including revision level) for this device. The format of
> >  the text string is arbitrary, although in conventional usage the 
> >string
> >  begins with the name of the device's manufacturer as with the name
> >  property.
> 
> That would be "0ABCDEF,Adder MPC875" or "VWXYZ,Adder MPC875" --
> not "some random string without a comma Adder MPC875".

"the text string is arbitrary" and "conventional usage".

That "random string" is more useful for the intended purpose than the
first half of a MAC address.

> >  Although there is no standard interpretation for the value of the 
> >model
> >  property, a specific device driver might use it to learn, for 
> >instance,
> >  the revision level of its particular device.
> 
> i.e., it is machine readable.

No, it *can* be machine usable in certain circumstances.  I'm 100% sure
that there is no code out there that cares what's in the model field of
this board's device tree, other than to pass it to /proc/cpuinfo (i.e.
human consumption).

-Scott
