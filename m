Date: Tue, 23 Nov 1999 20:21:15 +0100
From: Gerd Knorr <kraxel@goldbach.in-berlin.de>
Message-Id: <199911231921.UAA29621@goldbach.masq.in-berlin.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: tv tuner/video
In-Reply-To: <H0000a4207bc43dd@MHS>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> The bottle-neck for continuous capture of un-compressed, full-size video 
> comes from the hard-disk.

... and for compressed video from the CPU.  I'd expect today's hardware
is'nt fast enouth to handle full-sized video without hand-optimized
assembler code.  xawtv 3.0 can do mjpeg compression (uses libjpeg) and
handles half-sized pal @ 25fps without much trouble on new hardware.
Hav'nt tested that code on ppc, so there might be some byte order
problems...

  Gerd

-- 
<script>alert("WARNING: You have JavaScript enabled.");</script>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
