Date: Thu, 28 Sep 2000 21:25:51 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
cc: R Shapiro <rshapiro@bbn.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: beige g3 rage II xf4.0.1 and miBoot
In-Reply-To: <Pine.LNX.4.21.0009282015220.15193-100000@idd-01.imbc.gr>
Message-ID: <Pine.LNX.4.10.10009282124500.3468-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 28 Sep 2000, Kostas Gewrgiou wrote:
> PS> Any ideas why writing to a disabled pci device in ppc crashes
> the machine but not the x86 ones ? Is this something that can be fixed
> in the kernel or an arch thing ?

Usually the behavior on non-responding addresses can be configured in the host
bridge.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
