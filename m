Date: Fri, 30 Mar 2001 11:16:41 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Kaoru Fukui <k_fukui@highway.ne.jp>
Cc: Tom Gall <gall@rochcivictheatre.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Success kernel-243pre8-SMP(patch)(Re: spin_lock problem in recent
 k ernel
In-Reply-To: <20010330062000.Postino-000633@smtp01.highway.ne.jp>
Message-ID: <Pine.LNX.4.05.10103301046350.2139-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 30 Mar 2001, Kaoru Fukui wrote:
> +#ifndef CONFIG_SMP
>  	spin_lock(&init_mm.page_table_lock);
> +#endif

AFAIK spin_lock() is void when not compiling for SMP, so this is equal to just
removing the call.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
