Date: Mon, 23 Aug 1999 16:36:10 -0500
From: anthony tong <atong@uiuc.edu>
To: Tom Rini <trini@disparity.net>
Cc: brad allison <jackal@aol.net>, rshaw@inficad.com,
        Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org, puetzk@iastate.edu
Subject: Re: BootX enhancement request
Message-ID: <19990823163610.A31129@mango.genunix.net>
References: <Pine.SGI.4.00.9908231613030.7470-100000@osiris.office.aol.com> <Pine.BSF.3.96.990823162311.86405K-100000@silver.teardrop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.BSF.3.96.990823162311.86405K-100000@silver.teardrop.net>; from Tom Rini on Mon, Aug 23, 1999 at 04:27:46PM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini (Mon, Aug 23, 1999 at 04:27:46PM -0400):
> > I think you missed my point.  Don't get me wrong, that's cool to know.
> > But I was thinking more along the lines of a drop down menu to set the
> > resolution from BootX rather than cryptic kernel arguements.
> 
> So you want BootX to be able to do what Monitors & Sound can do.  Either
> pick a mode there and use BootX from MacOS, or once 2.4.0 rolls around,
> specify video=aty128fb:1024x768@75 (or so).  There is no need for BootX to
> do this.

If you have a version of MacOS that saves the monitor mode in nvram,
you shouldn't need to give any kernel arguments. Alternatively you
can use the linuxpmac tool nvvideo to set this.

It should be simple to add modedb support for the time being as well.

> > It seems the 2.2.10 kernel will not sync to the video settings at all
> > without the kernel arguements.

The default (without kernel arguments) is 640x480-60, unless you have
a video mode already set in nvram.

> What, aty128fb?  It's beta and not done.  You're prolly better off using
> No Video Driver, unles you're gonna play w/ the source (Anthony, speak up
> if i'm wrong). :)

If it works, use it, if not, send me an email. :)


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
