Date: Tue, 29 Jun 2004 08:16:04 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 2.5 bk tree on 8xx board ... so close
Message-ID: <20040629151603.GG28128@smtp.west.cox.net>
References: <Pine.LNX.4.60.0406281743170.4213@localhost.localdomain> <20040628233119.GE28128@smtp.west.cox.net> <Pine.LNX.4.60.0406290546500.3272@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.60.0406290546500.3272@localhost.localdomain>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jun 29, 2004 at 05:53:22AM -0400, Robert P. J. Day wrote:

> On Mon, 28 Jun 2004, Tom Rini wrote:
>
> >Which serial driver did you use?  For me 8xx_UART does not work, but
> >CPM_UART will (it's still not quite correct, I have to config in both
> >SMC1 and SCC1 to get SMC1 to work, but I'm burried under a bunch of
> >other stuff right now).
>
> i was, in fact, using 8xx_UART under the "MPC8xx CPM options" menu,
> but (pardon my confusion) i'm not aware of this CPM_UART option of
> which you speak (unless you're just paraphrasing).

Paraphrasing from memory, yes, sorry.

> if i deselect 8xx_UART, i'm assuming you're talking about going then
> to the menu selections:
>
>   Device Drivers
>     Character devices
>       Serial drivers
>
> and selecting the appropriate CONFIG_SERIAL_CPM* settings (_SCC1 and
> _SMC1)?  is that what you're referring to above?

Yes, that driver.  As I was saying, for some reason I haven't had time
to dig into, I have to select both SCC1 and SMC1 to get a console which
is on SMC1 working.  I've also found that enabling everything doesn't
horribly kill the board, so you could just try that for now.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
