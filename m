Date: Wed, 30 Jun 1999 11:54:27 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org, Geert.Uytterhoeven@cs.kuleuven.ac.be,
        Christian.Bauer@uni-mainz.de
Subject: Re: DGA applications not working
In-Reply-To: <19990630151455.027635@mail.mipsys.com>
Message-ID: <Pine.LNX.3.96LJ1.1b7.990630114404.2471A-100000@selq119.unl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 30 Jun 1999, Benjamin Herrenschmidt wrote:

> HI !
> 
> I'm having a problem with the XFBDev server that comes bundled with
> linuxppc R5, and I really don't know what's going on and how I can fix
> that. Basically, when I try to use a DGA-based application, I get an
> error message in the console saying:
> 
> "XF86DGAGetVideo: failed to mmap /dev/kmem (Device not configured)"
> 
> I'm using a 2.2.10 kernel with controlfb.
> 
> If someone what to test this, a DGA application that fails is Basilic II
> (Mac 68k emulator) that can be found at <http://www.uni-mainz.de/~bauec002/>
> 
> Any clues ?

I think it's simply that XF68_FBDev does not have enough codes to support
your DGA-based application.  For R5 rpms, I asked Tom Rini to include a
small patch which enables one or two DGA related calls so that xawtv can
get frame buffer addresses from X server.  To have a more or less complete
DGA support, somebody needs to hack on XF68_FBDev.


Takashi Oe


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
