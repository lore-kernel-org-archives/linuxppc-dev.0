Date: Tue, 18 Jul 2000 20:20:46 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Martin Costabel <costabel@wanadoo.fr>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: strace doesn't work on 2.4.0-testX
In-Reply-To: <39744BAA.6E5984DA@wanadoo.fr>
Message-ID: <Pine.LNX.4.10.10007182019150.488-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 18 Jul 2000, Martin Costabel wrote:
> The problem is that strace stopped working somewhere between
> 2.4.0-test1-ac18 and -ac21 (I have both kernels and verified just
> moments ago). It still doesn't work with 2.4.0-test5-pre2. Is this a
> known problem or am I doing something wrong? I haven't seen anything on
> the linux-kernel list (in the l-k archives, the last message with a
> similar subject is from 1996), so it could be a ppc-related problem.

IIRC this is a known problem, caused by some changes in the ptrace() syscall.

But IIRC, I did see an announce that someone did fix it on PPC. Or was that on
MIPS?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
