Date: Sat, 2 Feb 2002 09:47:53 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Armin <akuster@pacbell.net>
Cc: ppc_devel <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 4xx ocp proc_fs & pm
In-Reply-To: <3C5A74FB.5010104@pacbell.net>
Message-ID: <Pine.GSO.4.21.0202020946340.24693-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 1 Feb 2002, Armin wrote:
> I would like to add the ability of the ocp devices to provide a way to
> supply device information to users and to expand the power management of
> these devices through the proc file system.
>
> I have modeled the proc file system after the pci proc and pci pm
> implimentations.  Each driver would register a driver struct via a
> ocp_register.
>
> struct ocp_driver {

Have you read the documents about Patrick Mochel's new driver framework yet? It
is being merged into 2.5.x.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
