Date: Thu, 19 Oct 2000 15:22:23 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Xavier Grave <grave@ipno.in2p3.fr>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: initial console
In-Reply-To: <Pine.LNX.4.21.0010190919000.8107-100000@ipnpcu5>
Message-ID: <Pine.LNX.4.10.10010191522070.422-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 19 Oct 2000, Xavier Grave wrote:
> First of all : thanks.
> On Wed, 18 Oct 2000, Geert Uytterhoeven wrote:
> > What does /dev/console look like?
> Under 2.2.17 kernel (which boot...)
> [root@ipnpwpc3 /dev]>ls -la /dev/console
> crw-r--r--    1 root     root       5,   1 oct 19 08:24 /dev/console
> is this good or not ? Do you need more information ?

Major 5 minor 1 is correct.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
