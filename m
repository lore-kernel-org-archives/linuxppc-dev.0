Message-ID: <38C43875.1F7B4C70@pop.agri.ch>
Date: Tue, 07 Mar 2000 00:00:06 +0100
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: Dev-Linux <linuxppc-dev@lists.linuxppc.org>
Subject: Re: serial module in 2.3.x?
References: <38C3BE97.3DE053C9@pop.agri.ch> <38C42E7D.B537A3F0@pop.agri.ch> <20000306153213.E18383@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




Tom Rini wrote:
>
> On Mon, Mar 06, 2000 at 11:17:40PM +0100, Andreas Tobler wrote:
>
> > Some follow up,
> >
> > I hang in the procedure autoconfig from serial.c, I get out the msg.
> > 'Testing ttysx'.
> > this happens on a wallstreet & on a pm7200.
> > It takes a lot of time to find out where, since each freeze needs about
> > 10' to reboot (fsck)
>
> Well, don't do that.  serial.o (from drivers/char/serial.c) is for PC-style
> serial ports.  What you want to say Y to is CONFIG_MAC_SERIAL, or there abouts.
>

Well, it worked under 2.2.x, I need it for PCMCIA/CARDUS 'register
serial/unregister serial....' at least..


Thx
Andreas

Or, how do you enable pcmcia stuff??

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
