Date: Wed, 2 Aug 2000 22:18:08 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Keith Owens <kaos@ocs.com.au>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Where does ppc define __start___ksymtab?
In-Reply-To: <28827.965112049@ocs3.ocs-net>
Message-ID: <Pine.LNX.4.10.10008022216520.833-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 1 Aug 2000, Keith Owens wrote:
> Please cc: kaos@ocs.com.au on replies, I am not on this list.
>
> I have been trying to find where ppc defines __start___ksymtab and
> __stop___ksymtab symbols.  These delimit the __ksymtab entries for
> module symbols.  On every other architecture that supports modules,
> arch/xxx/vmlinux.lds contains lines like this
>
>   __start___ksymtab = .;	/* Kernel symbol table */
>   __ksymtab : { *(__ksymtab) }
>   __stop___ksymtab = .;
>
> I can find no equivalent lines for ppc in a stock 2.4.0-test5 source
> tree yet ppc obviously defines them somewhere.  But where?

I'm no gcc linkscript expert, but doesn't the absence of __ksymtab stuff in
vmlinux.lds simply mean that gcc can put stuff for section __ksymtab wherever
it wants in the final object file?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
