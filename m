Date: Wed, 19 May 2004 16:28:44 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: =?gb2312?q?Song=20Sam?= <samlinuxppc@yahoo.com.cn>
Cc: David Ho <DavidHo@nanometrics.ca>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: getting linux console on a frame buffer.
In-Reply-To: <20040519142327.9249.qmail@web15206.mail.bjs.yahoo.com>
Message-ID: <Pine.GSO.4.58.0405191627370.23702@waterleaf.sonytel.be>
References: <20040519142327.9249.qmail@web15206.mail.bjs.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 19 May 2004, [gb2312] Song Sam wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Wed, 19 May 2004, [gb2312] Song Sam wrote:
> > > But this isn't a solution to have a LINUX console
> > > on the frame buffer with serial port input.It DID
> > > output some boot message to LCD but the work
> > > console is still ttyS0.And you can type a command
> > > like "echo a /dev/tty0" to make the 'a' to
> > > LCD.Without such command,however,the input result
> > > still is displayed on serial console.Am I right?

    [...]

> > If you would modify the serial port driver to send
> > keyboard events to the input
> > subsystem, it would work, though.
>
> I am a little bit interested in this problem for my
> target USB keyboard didn't work right after an
> accident.I think I can get serial keyboard input on
> LCD as David wanted.Could you tell me more details on
> your idea,like how to modify it in 2.4.18?

I'm not that familiar with the input subsystem. I suggest to take a look how
the USB keyboard driver in 2.4 feeds keyboard events to the input subsystem.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
