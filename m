From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Date: Tue, 12 Dec 2000 12:25:49 +0100
Content-Type: text/plain;
  charset="US-ASCII"
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Linux/m68k <linux-m68k@lists.linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
References: <Pine.GSO.4.10.10012121204470.2376-100000@escobaria.sonytel.be>
In-Reply-To: <Pine.GSO.4.10.10012121204470.2376-100000@escobaria.sonytel.be>
Subject: Re: Mac/m68k patches?
MIME-Version: 1.0
Message-Id: <00121212254900.01193@enzo.bigblue.local>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tuesday 12 December 2000 12:05, Geert Uytterhoeven wrote:
> On Tue, 12 Dec 2000, Franz Sirl wrote:
> > On Tuesday 12 December 2000 10:12, Geert Uytterhoeven wrote:
> > > I have these Mac/m68k patches in my patchqueue which affect PowerMac as
> > > well. Anyone who has a problem with them, or can I send them to Linus?
> > >
> > > diff -urN linux-2.4.0-test12/drivers/input/keybdev.c
> > > linux-m68k-2.4.0-test12/drivers/input/keybdev.c ---
> > > linux-2.4.0-test12/drivers/input/keybdev.c	Fri Jul 28 03:36:54 2000 +++
> > > linux-m68k-2.4.0-test12/drivers/input/keybdev.c	Tue Dec 12 09:02:47
> > > 2000 @@ -90,7 +90,7 @@
> > >  	return 0;
> > >  }
> > >
> > > -#elif defined(CONFIG_ADB_KEYBOARD)
> > > +#elif defined(CONFIG_INPUT_ADBHID)
> > >
> > >  static unsigned char mac_keycodes[128] =
> > >  	{ 0, 53, 18, 19, 20, 21, 23, 22, 26, 28, 25, 29, 27, 24, 51, 48,
> >
> > This one is wrong, the right patch is in bk_2_3 and has been feeded to
> > Linus already, see my post on l-k last week. You can however trigger
> > Linus again to finally apply it :-). The patch to adbhid.c is fine with
> > me.
>
> You can increase your chances slightly by not sending the patch as an
> attachment, but by plainly including it in your mail.

Really? It's a 8-bit text/plain attachment and mutt displays it fine inline.
Saving the message saves it in one file and patch happily uses it as input.

Well, I can resend anyway I believe...

Franz.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
