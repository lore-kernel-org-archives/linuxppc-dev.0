Date: Mon, 3 Apr 2000 12:45:31 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: jingai <jingai@floatingpenguins.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: DMA Sound split & Atari800
In-Reply-To: <200004030525.BAA20207@shell.faradic.net>
Message-ID: <Pine.LNX.4.05.10004031244490.29587-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 3 Apr 2000, jingai wrote:
> I am trying to build Atari800 (the emulator) with sound support, and so far
> I have been successful, except that the output is very 'jittery.'  It
> sounds as if either a) each sample is being played twice, or b) the
> soundcard is initialized before each sample.  I was able to get it to
> produce sound by editing the Makefile to include -DSIGNED_SAMPLES
> -DPOKEYSND_BIG_ENDIAN.  *Occasionally* I can somehow get it to produce
> smooth sound, but each sample is drawn out, almost as if it is playing it
> twice as long (and it doesn't sync with the video).
>
> If there is anyone here that is more familiar with the current state of
> sound support in the 2.3.x PPC kernels (with all of the dmasound split
> patches applied), and would like to help me figure out why this is
> occuring, I would really appreciate it.  I just don't really know enough
> about the current state of sound support in the PPC kernels to know exactly
> what is wrong -- although I will continue to probe around.

Did it work before you applied the dmasound split patches?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
