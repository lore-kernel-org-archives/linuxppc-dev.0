Date: Thu, 27 Apr 2000 12:04:50 +0200
From: Bernhard Reiter <bernhard@intevation.de>
To: Mario Scarpa <m.scarpa@mondonet.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Lombard hard freeze
Message-ID: <20000427120450.F11120@cheops.usf.Uni-Osnabrueck.DE>
References: <20000424161311.23404.qmail@web1705.mail.yahoo.com>
	<20000424191708.C16557@cheops.usf.Uni-Osnabrueck.DE>
	<39058B20.7D29A470@mondonet.net>
	<20000425144459.E22219@cheops.usf.Uni-Osnabrueck.DE>
	<390594BF.97FD809E@mondonet.net>
	<20000426142256.J2544@cheops.usf.Uni-Osnabrueck.DE>
	<3906E33F.89D2E839@mondonet.net>
	<20000426192309.A8102@cheops.usf.Uni-Osnabrueck.DE>
	<39080659.B722F0C5@mondonet.net>
Mime-Version: 1.0
In-Reply-To: <39080659.B722F0C5@mondonet.net>; from m.scarpa@mondonet.net on Thu, Apr 27, 2000 at 08:20:25AM -0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Apr 27, 2000 at 08:20:25AM -0100, Mario Scarpa wrote:
> Bernhard Reiter wrote:
> >
> > Yes, unfortunatly it froze again even running the kernel withou usb.
> > All in all the bug seems to be harder to recreate today then
> > yesterday. (Maybe it is date related.)
>
> Ah. This changes the things...
> The only thing that comes to my mind is now the serial driver...
> It's possible that the way it interacts with the USB code triggers
> the problem better than something else: I should take a look to the code
> but the fact that the serial driver sometimes gives problems
> is a fact (btw, never experienced crashes during the boot when
> the system initializes the serial ports ?)

I do not remember crashes during the boot in the serial driver.

The strange thing is, that the bug was harder to recreate as usual
even with usb driver in the kernel yesterday.
Today it seems a bit easier.

If it is the serial port, maybe I should try to disable it in the
kernel.
	Bernhard

--
Professional Service around Free Software                (intevation.net)
The FreeGIS Project				            (freegis.org)
Association for a Free Informational Infrastructure            (ffii.org)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
