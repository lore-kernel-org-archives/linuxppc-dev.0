Date: Tue, 10 Oct 2000 21:53:48 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Simmons <jsimmons@suse.com>
cc: Samuel Rydh <samuel@ibrium.se>,
        Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>, olh@suse.de
Subject: Re: [linux-fbdev] Re: Video driver bug
In-Reply-To: <Pine.LNX.4.21.0010101702000.2113-100000@euclid.oak.suse.com>
Message-ID: <Pine.LNX.4.10.10010102150540.375-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 10 Oct 2000, James Simmons wrote:
> > > I have some ideas but it would requires some changes to the fbcon layer.
> > > Also it would move palette handling from fbdev to the console layer.
> > > Would these changes be included with the 2.4.0-testX kernels?
> >
> > I think we must do something in 2.4.0-testX, since you can abuse the bug to
> > panic the box.
>
> We really should design a cursor api. A api independent of the console so
> X servers can take advantage of it. IMHO fbcon-cfbX and freinds should
> go away. What I purpose is it be replaced by 3 standard functions:
>
> fillrect
> copyarea
> drawimage
>
> This with a clean cursor api woudl allow display_switch to go away.

100% agreed. But that should wait for 2.5.0. Now we have to hunt for
release-critical bugs in the current version.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
