Message-ID: <006601bfc119$0f4e5c00$d2d3470a@mike>
From: "Mike Hudson" <Exoray@isys.ca>
To: "Takashi Oe" <toe@unlserve.unl.edu>
Cc: <linuxppc-dev@lists.linuxppc.org>
References: <Pine.A41.3.96LJ1.1b7.1000518170657.15274D-100000@unlserve.unl.edu>
Subject: Re: BMAC+ & Full Duplex
Date: Thu, 18 May 2000 18:33:15 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Takashi,

I think we're talking about the same thing.
"Server mode" is like a modified auto-power on that will
ALWAYS boot the computer. i.e. it will boot whenever AC power is present.

I'm going off the technote at the apple website
(http://developer.apple.com/technotes/tn/tn1079.html) which specified
direct hardware access to the CUDA, can we do this from user-space using
ADB commands?

Here's what I was originally thinking about:

cuda_request(&req, NULL, 2, CUDA_PACKET, CUDA_SVR_MODE,
    CUDA_SVR_MODE_ENA)
called somewhere in the kernel
after
#define CUDA_SVR_MODE 0x13 (from apple technote)
#define CUDA_SVR_MODE_ENA 1
etc..
This could be called numerous ways.

Either way, send over the source code to your little app, Takashi. It would
be
exponentially more elegant than a kernel patch.

Mike Hudson

----- Original Message -----
From: "Takashi Oe" <toe@unlserve.unl.edu>
To: "Mike Hudson" <Exoray@isys.ca>
Cc: <linuxppc-dev@lists.linuxppc.org>
Sent: Thursday, May 18, 2000 6:14 PM
Subject: Re: BMAC+ & Full Duplex
>
> How does this "server mode" work on Mac OS?  I once wrote a little app to
> manipulate "auto power on command" via CUDA, and, if the server mode is
> just doing CUDA command every so often so that a machine will reboot
> automatically, you might be able to use the app with cron.  Not sure.
>
>
> Takashi Oe
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
