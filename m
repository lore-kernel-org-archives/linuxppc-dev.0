Date: Sun, 14 Oct 2001 23:57:39 -0400 (EDT)
From: Andrew P McPherson <apm@MIT.EDU>
To: Takashi Oe <toe@unlserve.unl.edu>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Compiling BootX?
In-Reply-To: <Pine.A41.3.96LJ1.1b7.1011014224838.138592A-100000@unlserve.unl.edu>
Message-ID: <Pine.GSO.4.30L.0110142354520.19922-100000@no-knife.mit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 14 Oct 2001, Takashi Oe wrote:

>
> On Sun, 14 Oct 2001, Andrew P McPherson wrote:
>
> > I'm attempting to port the experimental nubus-pmac kernel to 68k Macs
> > upgraded with a PowerPC card.  I have found that the BootX version
> > modified for the Nubus powermacs, avalable at nubus-pmac.sourceforge.net,
> > nearly works with my Quadra 700+PPC card, but that it hangs while
> > configuring the video.
>
> It would be very nice if we can build BootX with freely available tools,
> but, that said, I'd think Apple's MkLinux Booter should work on your
> machine.   Of course, you still need to port the kernel, but you have one
> less thing to worry about.
>

The problem with the MkLinux booter is that it refuses to run because it
doesn't recognize the machine as "supported."  Is the source of the
MkLinux booter available so that I could disable that "feature," or was
that a closed-source effort by Apple?

-Andrew


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
