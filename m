Date: Sat, 10 Mar 2001 22:59:34 -0500 (EST)
From: Bill Fink <billfink@capu.net>
To: linuxppc-dev@lists.linuxppc.org
Cc: iain@sandoe.co.uk, billfink@capu.net
Subject: Re: UPDATE dmasound to 2.4.3p3
Message-ID: <Pine.LNX.4.21.0103102243530.18429-100000@gwiz.nasa.atd.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Iain,

How much of an effort would it be to add support for the
SNDCTL_DSP_GETIPTR/SNDCTL_DSP_GETOPTR ioctls to the dmasound
driver?  I am working on porting xine to PPC and it requires
the GETOPTR ioctl to provide timing information to synchronize
the audio and video.  As a temporary kludge, I managed to get
the 0.3.7 version of xine to work by using the real time clock
to provide pseudo timing information just based on the 44.1 KHz
audio sampling rate, but this is obviously sub-optimal at best,
and may be more problematic with the newer 0.4.01 version of
xine that just added true audio/video synchronization support.

					-Thanks in advance

					-Bill


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
