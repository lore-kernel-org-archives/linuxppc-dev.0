Date: Sun, 11 Mar 2001 11:29:08 +0000
Subject: Re: UPDATE dmasound to 2.4.3p3
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Bill Fink <billfink@capu.net>
Cc: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010311112952.1D8872F08C@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Bill,

> How much of an effort would it be to add support for the
> SNDCTL_DSP_GETIPTR/SNDCTL_DSP_GETOPTR ioctls to the dmasound
> driver?  I am working on porting xine to PPC and it requires
> the GETOPTR ioctl to provide timing information to synchronize
> the audio and video.  As a temporary kludge, I managed to get
> the 0.3.7 version of xine to work by using the real time clock
> to provide pseudo timing information just based on the 44.1 KHz
> audio sampling rate, but this is obviously sub-optimal at best,
> and may be more problematic with the newer 0.4.01 version of
> xine that just added true audio/video synchronization support.

I discussed the xine issues briefly with Henry Worth and...

(1) I think I can fix the bug that makes the dmasound driver claim to be
able to do 48K (when it can't) quickly (as in prob. today).

(2) I'll look at the GETXPTR stuff.... later on.

(3) Implementing mmio doesn't appeal to me until we can lose the translation
code completely.  I might do a "CONFIG_LEAN" version soon-ish.

so - let's see what happens later today ;-)

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
