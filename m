Date: Tue, 16 Nov 1999 18:45:27 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: toa@pop.agri.ch
cc: Ani Joshi <ajoshi@shell.unixbox.com>,
        Dev-Linux <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Kernel debugging??
In-Reply-To: <38318048.B414DC12@schweiz.ch>
Message-ID: <Pine.LNX.4.05.9911161844270.25661-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 16 Nov 1999, Andreas Tobler wrote:
> Ani Joshi wrote:
> >         since you're on a powermac and using BootX, you can use
> > prom_print() to print debuging info before start_kernel, there after you
> 
> This what I'm doing now.
> But I feel a bit lost when it goes into asm.
> 
> > can just use printk().  instead of putting a million prints all over the
> > place, you should look at the patches between 2.3.25-2.3.28 and see what
> > was changed in ppc/kernel or ppc/mm ,

2.3.28 gets sufficiently far to get output on the serial console
(console=ttyS0).

> This I also did, on the mm side do I have to include both mm and
> arch/ppc/mm?
> Here many changes happened.
> 
> > i've booted 2.3.25 on my 7200 
> And I could boot a stock 2.3.26 with changes in asm-ppc/fcntl.h
> (O_LARGEFILE ....)

That's very interesting to know! It means we just have to analyse the 2.3.27
and 2.3.28 patches to find out what went wrong.

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
