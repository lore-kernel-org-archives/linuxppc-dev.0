Date: Tue, 25 Jul 2000 20:42:56 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
cc: Godmar Back <gback@cs.utah.edu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: diff to tonight's kaffe cvs tree to work on ppc
In-Reply-To: <397DCCDD.5BF75110@ivey.uwo.ca>
Message-ID: <Pine.LNX.4.10.10007252039040.1490-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 25 Jul 2000, Kevin B. Hendricks wrote:
> Will you you replace the kaffe_cleanups.patch I just sent you with the slightly
> revised one attached.
>
> After some discussions with Tom Gall (of IBM for Linux and 64bit ppc and Linux),
> it would be better to change the unsigned int types I used in the align with
> unsigned long.

Which has been a general remark since ages (the first 64-bit Linux port (AXP)
was started in 1995): _never_ put pointers in an int, use long.

To catch more bugs, use SPARC64: it is big endian and 64-bit. Or better, use
64-bit PPC when available, since it also has chars that are unsigned by
default.

So far for the 3 most occurring portability problems with Linux.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
