Date: Wed, 17 Nov 1999 20:49:53 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ani Joshi <ajoshi@shell.unixbox.com>
cc: Andreas Tobler <a.tobler@schweiz.ch>,
        Linux -Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: again 2.3.28
In-Reply-To: <Pine.LNX.4.10.9911171133220.5126-100000@shell.unixbox.com>
Message-ID: <Pine.LNX.4.05.9911172048000.25661-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 17 Nov 1999, Ani Joshi wrote:
> 	i messed aroudn with .28 last night and it seems to die *after*
> mmu_init but before start_kernel, you can test this by making and export a
> function which simply prom_print("got here\n");'s and then calling it from
> head.S with the asm "bl	my_got_here_function".  it also gets passed
> loading the new hash table.

Probably it depends on the machine, since I get up to free_all_bootmem(), which
is called by mem_init() in start_kernel(). OK, I have a different box (CHRP)
and was actually speaking about 2.3.27, but the 2.3.28 patch doesn't contain
relevant changes.

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
