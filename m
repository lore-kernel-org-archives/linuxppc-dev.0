Date: Tue, 8 Aug 2000 18:54:34 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Josh Huber <huber@mclx.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [Dri-devel] Re: Kind of success! (r128 on PPC (Re: LinuxPPC X
 Server))
In-Reply-To: <20000808091311.B248@mclx.com>
Message-ID: <Pine.LNX.4.10.10008081853280.13215-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >
> > Is this XF4.0.1 in `fbdev' mode? If yes, it's a bug in the X server. Setting
> > the DSP registers is part of the video mode initialization and thus is the
> > sole responsability of the frame buffer device, when running in `fbdev' mode.
>
> Yes.  The server shows the SAME behavior using the fbdev driver and
> the ati driver.  Also, as a note, the 3.3.6 XF68FB_Dev server with ati
> accel also does the same thing!   So there's some code that's getting
> used by all three that is wrong?

Both the fbdev and ati driver use the fbdvhw functions to do mode init and
the like. So it seems the bug is in the kernel driver (sorry Geert).

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
