Date: Tue, 7 Aug 2001 09:49:38 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: daenzer@debian.org
Cc: R Shapiro <reshapiro@mediaone.net>, Olaf Hering <olh@suse.de>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: lcd17 kernel patches?
In-Reply-To: <3B6E8B6E.BED87E1A@iogram.ch>
Message-ID: <Pine.LNX.4.05.10108070947420.5836-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 6 Aug 2001, Michel Dänzer wrote:
> R Shapiro wrote:
> > Olaf Hering writes:
> >  > The correct fix is either "video=1280x1024-8@60" as kernel arg (that may
> >  > work)
> >
> > OK, I just had time to rebuild 2.4.8-pre3-ben0 with the patch undone.
> > This video arg with that kernel doesn't solve the problem.  I still
> > get no video on boot.
>
> Wouldn't it have to be video=aty128fb:1280x1024-8@60 anyway, and is the modedb

video=mode specifies the global mode, for all fbdevs that use modedb.

> even used on PPC yet?

That's not the right question :-) Modedb doesn't depend on the architecture,
but on the driver.

Yes, atyfb was the first one to have modedb. Remember, I have a RAGE II+ in my
LongTrail :-)

PowerMac/CHRP has even extra modedb support in macmodes.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
