Subject: Re: TiBook-PowerBook XF86Config-4 - gpm
From: Vincent Katz <vincent.katz@laposte.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <Pine.GSO.4.21.0111151735180.28940-100000@mullein.sonytel.be>
References: <Pine.GSO.4.21.0111151735180.28940-100000@mullein.sonytel.be>
Content-Type: text/plain
Date: 15 Nov 2001 18:33:05 +0100
Message-Id: <1005845625.16586.195.camel@avalon>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


OK, i understand, i am "out", i am in 2.4.10 ;-) i try .14.
thx


On 15 Nov 2001 17:35:45 +0100, Geert Uytterhoeven wrote:
> On Thu, 15 Nov 2001, Benjamin Herrenschmidt wrote:
> > >me too, i have a tibook and i'm interesting for your XF86Config-4.
> > >
> > >I have a little probleme with the console mode and gpm (v:1.19.6), for
> > >the cut and paste i have an alteration of the characters, i don't know
> > >why ?
> >
> > This is a problem when VGA console support is enabled in the kernel
> > config. (Beware that if you disable it, you must make distclean before
> > recompiling to get proper display).
> >
> > I know Geert had a fix for that, I'm not sure if that was included in
> > upstream sources or not as I didn't have this option checked for monthes
> > in my kernel.
>
> Accepted by Linus in 2.4.13 or so.
>
> Gr{oetje,eeting}s,
>
> 						Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
