Date: Mon, 6 Mar 2000 15:32:13 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andreas Tobler <toa@pop.agri.ch>
Cc: Dev-Linux <linuxppc-dev@lists.linuxppc.org>
Subject: Re: serial module in 2.3.x?
Message-ID: <20000306153213.E18383@opus.bloom.county>
References: <38C3BE97.3DE053C9@pop.agri.ch> <38C42E7D.B537A3F0@pop.agri.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <38C42E7D.B537A3F0@pop.agri.ch>; from toa@pop.agri.ch on Mon, Mar 06, 2000 at 11:17:40PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Mar 06, 2000 at 11:17:40PM +0100, Andreas Tobler wrote:

> Some follow up,
>
> I hang in the procedure autoconfig from serial.c, I get out the msg.
> 'Testing ttysx'.
> this happens on a wallstreet & on a pm7200.
> It takes a lot of time to find out where, since each freeze needs about
> 10' to reboot (fsck)

Well, don't do that.  serial.o (from drivers/char/serial.c) is for PC-style
serial ports.  What you want to say Y to is CONFIG_MAC_SERIAL, or there abouts.

---
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
