Date: Fri, 16 Jan 2004 13:03:25 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Colin Leroy <colin@colino.net>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] therm_* drivers need i2c-keywest
In-Reply-To: <20040116124158.24db8307.colin@colino.net>
Message-ID: <Pine.GSO.4.58.0401161302570.14892@waterleaf.sonytel.be>
References: <20040116122756.034fc736.colin@colino.net>
 <20040116124158.24db8307.colin@colino.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 16 Jan 2004, Colin Leroy wrote:
> On 16 Jan 2004 at 12h01, Colin Leroy wrote:
> > This patch lets the different pmac thermostat drivers try to load
> > i2c-keywest if necessary and possible.
>
> As I didn't saw that request_module() errors if the module is already loaded (heh.), a better version of this is to avoid checking return value...
> See attached.

And you want to drop the #ifdef CONFIG_KMOD, since that's already in
<linux/kmod.h>.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
