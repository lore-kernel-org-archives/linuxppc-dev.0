Date: Fri, 24 Mar 2000 10:06:35 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: "William H. Schultz" <whschult@uncc.edu>
cc: Michel Dänzer <michdaen@iiic.ethz.ch>, linuxppc-dev@lists.linuxppc.org
Subject: Re: XFree86 4.0 Generic VGA
In-Reply-To: <B5002664.69%whschult@uncc.edu>
Message-ID: <Pine.LNX.4.10.10003241001470.17333-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> On a fresh install, typeing  XFree86 -configure brings up the following
> (note that for some reason, the tdfx driver is not installed.  Like I asked
> before:  where can I get it?  Also note that I'm running on a 2.2.14
> kernel):

> (II) Loading /usr/X11R6/lib/modules/drivers/tdfx_drv.o

					      ^^^^^^^^^^

Pardon my ignorance, but isn't this the module you were looking for?

(XFree doesn't use separate drivers for different cards anymore but rather
specialized driver modules.)

> (II) Module tdfx: vendor="The XFree86 Project"
>     compiled for 3.9.16, module version = 1.0.0

The module version is funny ... maybe it was leftover from a previous
install?

> (II) Loading /usr/X11R6/lib/modules/drivers/fbdev_drv.o
> (II) Module fbdev: vendor="The XFree86 Project"
>     compiled for 4.0, module version = 0.1.0
>
> Fatal server error:
> Caught signal 11.  Server aborting
>
> Apparently it was compiled on 2.2.15, but I'm running 2.2.14.  Oh yeah, the
> tdfx driver that is in there, I copied from a 3.9.16 install that actually
> had the driver.  It gives the same error whether it's there or not.

That explains the driver versio, OK. What does the "Device" section of
your XF86Config look like?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
