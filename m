Date: Tue, 12 Dec 2000 12:05:35 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: Mac/m68k patches?
In-Reply-To: <00121211501400.01036@enzo.bigblue.local>
Message-ID: <Pine.GSO.4.10.10012121204470.2376-100000@escobaria.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 12 Dec 2000, Franz Sirl wrote:
> On Tuesday 12 December 2000 10:12, Geert Uytterhoeven wrote:
> > I have these Mac/m68k patches in my patchqueue which affect PowerMac as
> > well. Anyone who has a problem with them, or can I send them to Linus?
> >
> > diff -urN linux-2.4.0-test12/drivers/input/keybdev.c
> > linux-m68k-2.4.0-test12/drivers/input/keybdev.c ---
> > linux-2.4.0-test12/drivers/input/keybdev.c	Fri Jul 28 03:36:54 2000 +++
> > linux-m68k-2.4.0-test12/drivers/input/keybdev.c	Tue Dec 12 09:02:47 2000 @@
> > -90,7 +90,7 @@
> >  	return 0;
> >  }
> >
> > -#elif defined(CONFIG_ADB_KEYBOARD)
> > +#elif defined(CONFIG_INPUT_ADBHID)
> >
> >  static unsigned char mac_keycodes[128] =
> >  	{ 0, 53, 18, 19, 20, 21, 23, 22, 26, 28, 25, 29, 27, 24, 51, 48,
>
> This one is wrong, the right patch is in bk_2_3 and has been feeded to Linus
> already, see my post on l-k last week. You can however trigger Linus again to
> finally apply it :-). The patch to adbhid.c is fine with me.

You can increase your chances slightly by not sending the patch as an
attachment, but by plainly including it in your mail.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
