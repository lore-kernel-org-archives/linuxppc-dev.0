Date: Thu, 9 Mar 2000 08:33:59 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Sean Harding <sharding@dogcow.org>
cc: David Edelsohn <dje@watson.ibm.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: compiler optimization? something else?
In-Reply-To: <Pine.GSO.4.05.10003081359150.17227-100000@ophelia.dogcow.org>
Message-ID: <Pine.LNX.4.05.10003090827380.4093-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 8 Mar 2000, Sean Harding wrote:
> On Wed, 8 Mar 2000, David Edelsohn wrote:
> (FWIW, another metric...It took 41 minutes to compile a kernel on the
> powermac. It took just over 6 minutes on my PII 350 desktop. The pentium
> was compressing an mp3 at the same time).

I assume the PPC compiled a PPC kernel and the ia32 compiled an ia32 kernel?
Then your benchmark is irrelevant since it hides the complexity difference for
generating good code between ia32 and PPC.
Please redo the timings cross-compiling a PPC kernel on the ia32 or
cross-compiling an ia32 kernel on the PPC.

BTW, if you do timings for integer wavelet transforms, you'll find out that the
PPC is about as fast (or faster) than the PII 350. For this particular case my
200 MHz 604e outperformed all PCs and Suns I had access to at the university
(SMP doesn't count).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
