Date: Tue, 24 Apr 2001 21:12:43 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: jeramy b smith <ultrapenguin@netscape.net>
Cc: mlan@cpu.lu, linuxppc-dev@lists.linuxppc.org
Subject: Re: Rsync access through NAT?
In-Reply-To: <5C7B5EF3.57179C98.A41E0FAA@netscape.net>
Message-ID: <Pine.LNX.4.05.10104242110570.2280-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 24 Apr 2001, jeramy b smith wrote:
> I'm not sure. The routers are cisco 55xx and 75xx with the latest firmware loaded. From there it hits the SprintLink and Abovenet clouds. I wish there was a tool that could do an point to point traceroute like journey and stop when it hits a hop that doesn't support ECN. Or does traceroute do this when used with 2.4 and ECN support on?

I think it does.

> -jeramy b smith
>
> mlan@cpu.lu wrote:
> > Yup, that seems to be the problem. rsync works again for me on
> > penguinppc. So I guess that some device close to penguinppc.org doesn't
> > support ECN.....

Then why can I ping penguinppc.org without problems? Because my AXP firewall
still runs 2.2.x?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
