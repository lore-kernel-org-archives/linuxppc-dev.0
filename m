Mime-Version: 1.0
Message-Id: <v04220800b50e0605be00@[10.0.0.42]>
In-Reply-To: <200004030525.BAA20207@shell.faradic.net>
References: <200004030525.BAA20207@shell.faradic.net>
Date: Mon, 3 Apr 2000 01:33:15 -0700
To: jingai@floatingpenguins.com, linuxppc-dev@lists.linuxppc.org
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: DMA Sound split & Atari800
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 1:25 AM -0400 4/3/00, jingai wrote:
>I am trying to build Atari800 (the emulator) with sound support, and so far
>I have been successful, except that the output is very 'jittery.'  It
>sounds as if either a) each sample is being played twice, or b) the
>soundcard is initialized before each sample.  I was able to get it to
>produce sound by editing the Makefile to include -DSIGNED_SAMPLES
>-DPOKEYSND_BIG_ENDIAN.  *Occasionally* I can somehow get it to produce
>smooth sound, but each sample is drawn out, almost as if it is playing it
>twice as long (and it doesn't sync with the video).

Do you know whether this behavior is unique on Linux for PowerPC?
That is, does it also do it on x86?  It may just be a problem with
the emulator; emulation of the sound chips on old computers is a
tricky job.

It could also be a bug in the emulator.  For example, it may be
assuming that the sound chip has a buffer length similar to whatever
is common on x86, causing it to screw up when it's in a different
world.

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
