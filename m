Date: Wed, 17 Nov 1999 21:18:44 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ani Joshi <ajoshi@shell.unixbox.com>
cc: Linux -Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: again 2.3.28
In-Reply-To: <Pine.LNX.4.10.9911171209470.5504-100000@shell.unixbox.com>
Message-ID: <Pine.LNX.4.05.9911172118130.25661-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 17 Nov 1999, Ani Joshi wrote:
> On Wed, 17 Nov 1999, Geert Uytterhoeven wrote:
> > Probably it depends on the machine, since I get up to free_all_bootmem(), which
> > is called by mem_init() in start_kernel(). OK, I have a different box (CHRP)
> > and was actually speaking about 2.3.27, but the 2.3.28 patch doesn't contain
> > relevant changes.
> 
> 	could your problem in free_all_bootmem() be caused by
> "if(!bootmem_map) BUG();"?  because in do_init_bootmem()
> it frees the bootmem bitmap (which is called very early).  
> is it trying to free something thats already been free'd?
> 
> its possible this is happening on pmacs also...

As I posted before (last Friday), it gets further than that.

I'll try Paul's tree...

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
