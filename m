Date: Fri, 16 Jan 2004 12:10:59 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Colin Leroy <colin@colino.net>
Cc: valvoline@vrlteam.org,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: temp.c and cputable.c issues
In-Reply-To: <14de01c3dc1a$70830140$3cc8a8c0@ANOSP>
Message-ID: <Pine.GSO.4.58.0401161210280.14892@waterleaf.sonytel.be>
References: <20040114193910.GN2658@adapter.n0skillz.org>
 <20040114221018.GB983@stop.crashing.org> <20040114201153.GO2658@adapter.n0skillz.org>
 <125601c3db40$50b11bc0$3cc8a8c0@ANOSP> <20040115071604.GR2658@adapter.n0skillz.org>
 <12b901c3db4a$81d1f7b0$3cc8a8c0@ANOSP> <20040116070249.GT2658@adapter.n0skillz.org>
 <14de01c3dc1a$70830140$3cc8a8c0@ANOSP>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 16 Jan 2004, Colin Leroy wrote:
> > i gotta it! :)
> > for some strange reason i need to modprobe manually the i2c_west,
> > first of all...next if i modprobe:
>
> Can you try the attached patch (apply against
> drivers/macintosh/therm_adt7467.c).
> Then, try to modprobe therm_adt7467 without i2c-core and i2c-keywest
> loaded.
>
> Tell me if this works.

If you look at <linux/kmod.h>, you'll notice your patch won't work, since
request_module() is a dummy if CONFIG_KMOD is not set.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
