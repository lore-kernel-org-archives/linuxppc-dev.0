Date: Sun, 8 Feb 2004 23:07:06 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Linux/m68k on Mac <linux-mac68k@mac.linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: drivers/macintosh/Kconfig (was: Re: Linux 2.6.3-rc1)
In-Reply-To: <1076275377.885.88.camel@gaston>
Message-ID: <Pine.GSO.4.58.0402082305270.8349@waterleaf.sonytel.be>
References: <Pine.LNX.4.58.0402061823040.30672@home.osdl.org>
 <Pine.GSO.4.58.0402081436370.2443@waterleaf.sonytel.be> <1076275377.885.88.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 9 Feb 2004, Benjamin Herrenschmidt wrote:
> On Mon, 2004-02-09 at 01:25, Geert Uytterhoeven wrote:
> > +config ADB
> > +	bool "Apple Desktop Bus (ADB) support"
> > +	depends on MAC || PPC_PMAC
> > +	help
> > +	  Apple Desktop Bus (ADB) support is for support of devices which
> > +	  are connected to an ADB port.  ADB devices tend to have 4 pins.
> > +	  If you have an Apple Macintosh prior to the iMac, an iBook or
> > +	  PowerBook, or a "Blue and White G3", you probably want to say Y
> > +	  here.  Otherwise say N.
>
> I'd be more precise, like: ADB devices are usually input devices (mice
> and keyboards) connected via a 4 pin daisy chained bus. All Apple
> laptops also use ADB internally for the built-in keyboar & trackpad.

I just moved the old help text, I didn't modify it.

> Now, for Cuda and PMU, as long as you let them be selected even
> without CONFIG_ADB, it's fine.

That's what I did...

BTW, why do some of these conflict with POWER4? Can't you build a generic
kernel that runs on both PowerMac and POWER4?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
