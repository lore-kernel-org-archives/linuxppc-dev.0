Date: Fri, 9 Jun 2000 09:27:54 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Stefan Jeglinski <jeglin@4pi.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: compiling new imsttfb?
In-Reply-To: <v04220800b565e4500d98@[192.168.0.1]>
Message-ID: <Pine.LNX.4.05.10006090924480.2302-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 8 Jun 2000, Stefan Jeglinski wrote:
> I was browsing comp.os.linux.powerpc and saw mention of a new
> imsttfb.c that I nabbed off <http://fortyoz.org/~ror/linux/>.
>
> For grins I thought I'd try compiling this new imsttfb.c (dated
> 22-May) in with the 2.2.15 linux-pmac-stable (rsynced about 2 weeks
> ago).
>
> But, the new imsttfb.c is substantially different than the one
> included with the rsynced version. In particular, the entire
> imsttfb_of_init function is excised, and this causes the compile to
> fail:
>
> offb.o(.text.init+0x47c): undefined reference to `imsttfb_of_init'
> offb.o(.text.init+0x47c): relocation truncated to fit: R_PPC_REL24
> imsttfb_of_init
> make: *** [vmlinux] Error 1
>
> Is there any easy way to modify this properly? My intuition is
> telling me that this new imsttfb is so different it won't compile
> under any circumstances with the linux source I have, regardless of
> my question above. Is there a better version I can try?

The new one uses PCI probing only, which is good. I suggest removing all
references to imsttfb from drivers/video/offb.c.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
