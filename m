Message-ID: <3AF65BCE.70A0F40F@relog.ch>
Date: Mon, 07 May 2001 10:24:46 +0200
From: Michel =?iso-8859-1?Q?D=E4nzer?= <daenzer@relog.ch>
Reply-To: michdaen@iiic.ethz.ch
MIME-Version: 1.0
To: Mike Willhide <moridin@psu.edu>
Cc: Linux Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Video drivers and XFree86 4
References: <B71B6D25.3184%moridin@psu.edu>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Mike Willhide wrote:

> I remember that in order to have an accelerated x server with 3.3.6 you
> needed both a driver to put into the kernel and an x server that is
> accelerated for your particular card.  Has 4.0.x done away with the
> necessity of multiple x servers?

Yes, there is only one server binary anymore which loads drivers etc. as
modules.

> If so, do you only need to have a driver for the particular card to get x
> accelerated (is a driver for x a different thing than a driver for the
> kernel)?

Yes and yes. An XFree86 driver is enough in most cases; Only a kernel driver
(or none at all) is good for unaccelerated X.

>     Also, does anyone know the status of the Radeon drivers for LinuxPPC?

Last I heard was it wasn't working with acceleration. Maybe Ani Joshi has made
progress in his tree.


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
