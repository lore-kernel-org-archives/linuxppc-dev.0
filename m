Date: Thu, 13 Mar 2003 22:17:29 -0500
From: Bill Fink <billfink@mindspring.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Serial Console on XServe and yaboot???
Message-Id: <20030313221729.220873a5.billfink@mindspring.com>
In-Reply-To: <1047476566.18957.61.camel@zion.wanadoo.fr>
References: <20030311223353.00f9a059.billfink@mindspring.com>
	<1047455184.18956.27.camel@zion.wanadoo.fr>
	<20030312081931.2cafbb86.billfink@mindspring.com>
	<1047476566.18957.61.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 12 Mar 2003, Benjamin Herrenschmidt wrote:

> On Wed, 2003-03-12 at 14:19, Bill Fink wrote:
> >
> > On 12 Mar 2003, Benjamin Herrenschmidt wrote:
> >
> > > iirc, there is something weird with the OF params for the console
> > > on the xserve. Try changing these:
> > >
> > > intput-device    "scca"
> > > output-device    "scca"
> > > input-device-1   "scca"
> > > output-device-1  "scca"
> >
> > Thanks for the idea, but unfortunately it had no effect, as I saw
> > no yaboot screens show up when I did a reboot.  Is it possible that
> > the initial OF uses a different baud rate than 38400 (although I
> > didn't even see any garbage show up)?
>
> Hrm... I did manage to get it last time I played with an xserve. I
> don't remember the baudrate though (maybe 57600...)

I determined it is indeed 57600.  Does anyone know of any OpenFirmware
parameter on the XServe to set the baud rate of the serial port?
Unfortunately my current console server maxes out at 38400.

						-Bill

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
