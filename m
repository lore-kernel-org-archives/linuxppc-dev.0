Message-ID: <20040519144554.66139.qmail@web15214.mail.bjs.yahoo.com>
Date: Wed, 19 May 2004 22:45:54 +0800 (CST)
From: Song Sam <samlinuxppc@yahoo.com.cn>
Subject: Re: getting linux console on a frame buffer.
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: David Ho <DavidHo@nanometrics.ca>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <Pine.GSO.4.58.0405191627370.23702@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > If you would modify the serial port driver to send keyboard events
> > > to the input subsystem, it would work, though.

> > I am a little bit interested in this problem for my target USB
> > keyboard didn't work right after an accident.I think I can get
> > serial keyboard input on LCD as David wanted.Could you tell me more
> > details on your idea,like how to modify it in 2.4.18?

> I'm not that familiar with the input subsystem. I suggest to take a
> look how the USB keyboard driver in 2.4 feeds keyboard events to the
> input subsystem.

OK,I will.But my focus was what you suggested,modify a
serial port driver.If this change looks a little bit
easier,I would take this first.Anyway,USB keyboard
driver is a headache for me.

Many thanks!

Sam

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
