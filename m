Date: Sun, 7 Oct 2001 19:04:53 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: still no luck with Radeon or Adaptec SCSI controller in 2.4.X
Message-ID: <20011007190453.B24315@cpe-24-221-152-185.az.sprintbbd.net>
References: <v03110700b7e6434b6153@[64.230.151.19]> <20011008014159.MXEV19401.tomts15-srv.bellnexxia.net@there> <20011007184922.A24315@cpe-24-221-152-185.az.sprintbbd.net> <20011008015829.BVRR3504.tomts19-srv.bellnexxia.net@there>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011008015829.BVRR3504.tomts19-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Oct 07, 2001 at 10:00:43PM -0400, Kevin B. Hendricks wrote:
> Hi Tom,
>
> > This is what modules are for. :)
> > /etc/modules.conf:
> > alias eth0 bmac
> > alias eth1 tulip  # or de4x5, since tulip is broken on some cards
>
> Ah...I never thought of that.
>
> By the way, do you know of any way to open a shell session in one specific
> framebuffer?

If you have 2 you mean?  video=map:000111 will put tty[1-3] on fb0 and
tty[4-6] on fb1.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
