Date: Tue, 22 Aug 2000 18:52:26 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "William H. Schultz" <whschult@uncc.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Control fb problem on 8500
In-Reply-To: <39A25B16.4A3DD5BC@uncc.edu>
Message-ID: <Pine.LNX.4.10.10008221850420.377-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 22 Aug 2000, William H. Schultz wrote:
> For all of you saying that controlfb is broken...  I rsynced the
> bitkeeper tree a few days ago, got it to compile, booted, etc...
> however:  I have a voodoo3 card, and it is set as my main display.  The
> voodoo3 was ignored, and the video went straight to the built in
> controlfb on my 8500.  It worked just fine, and it worked the best it's
> worked in quite some time.  I had no video artifacts at all, and
> everything worked...  nice and smooth...  etc....  etc...
>
> But the only way for me to use the voodoo3 (which is the card supporting
> my BIG monitor) is to completely disable the video drivers from Boot
> X...  odd quirk...

So your voodoo3 does work with offb (video=ofonly or `no video driver')?

In that case I'd expect it to work as well without `no video driver', since
that would mean controlfb takes the control hardware, and offb takes what's
left (i.e. the voodoo3).

Or are you using the 2.2.x bk tree and not 2.3.x?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
