Date: Mon, 12 Jul 1999 16:24:36 -0400 (EDT)
From: Peter Handel <phandel@cise.ufl.edu>
To: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: HELP - I'm going mad: mp3,audio/adb conflict
Message-ID: <Pine.GSO.4.05.9907121622120.1273-100000@eclipse.cise.ufl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Does anyone have an idea where I could start hunting for a fix for
this?  I've never really fiddled with the kernel before; too bad I
can't sick gdb on it :)  What's driving me nuts is that precompiled
kernels work perfectly [read problem description below].


Thanks,
Peter

On Sun, Jun 27, 1999 at 11:46:49PM -0400, Tom Rini wrote:

> > 1) Say I'm playing an mp3 with either xmms or mpg123.  If I move a
> > window around w/the mouse, the music will stop completely!  I have to
> > quit xmms/mpg123 and restart it for it to work again.  This only
> > happens with kernels I compile myself.  I have even tried compiling
> > 2.2.10 and 2.3.6 with all default values, but still the same problem.
> > (Had same problem under r4!)  The only constant here is egcs 2.91.66,
> > which I built under r4 and which came prebuilt in r5.  This has been
> > extremely frustrating, as I'd like to start playing with the kernel
> > code myself.

> This sounds very wierd.  And you're doing nothing different other then
> using a different kernel for sound to work/not work properly?

This has been a long-standing problem for me with all kernels starting at
2.1.12x and continuing to present. It was *never* a problem with 2.1.24,
but there were apparently some changes in the sound driver post-2.1.24
(e.g., you used AFMT_S16_BE in 2.1.24, and little-endian or "NE" in
later kernels). Incidentally, I made the 2.1.24->2.1.121 jump, so I
don't know at what version it may have been a problem. It appears with
all apps that use the sound device that I have tried -- amp, mpg123,
timidity and xaudio.  The load average on the machine doesn't seem to
matter -- it seems to be solely related to mouse movements, and appears
with both XF68_FBDev and Xpmac.

It is not related to the compiler version, as I have had the problem
with various versions of egcs.

-- 
Check out the comp.sys.mac.advocacy FAQ
http://www.pobox.com/~ericb/csmafaq/ 

muahahahahahahaha!!!snap!snap!!snap!!photoshop!!
  -- Ho You Kong



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
