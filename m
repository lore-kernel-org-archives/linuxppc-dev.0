Date: Tue, 29 Jun 2004 05:53:22 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 2.5 bk tree on 8xx board ... so close
In-Reply-To: <20040628233119.GE28128@smtp.west.cox.net>
Message-ID: <Pine.LNX.4.60.0406290546500.3272@localhost.localdomain>
References: <Pine.LNX.4.60.0406281743170.4213@localhost.localdomain>
 <20040628233119.GE28128@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 28 Jun 2004, Tom Rini wrote:

> Which serial driver did you use?  For me 8xx_UART does not work, but
> CPM_UART will (it's still not quite correct, I have to config in both
> SMC1 and SCC1 to get SMC1 to work, but I'm burried under a bunch of
> other stuff right now).

i was, in fact, using 8xx_UART under the "MPC8xx CPM options" menu,
but (pardon my confusion) i'm not aware of this CPM_UART option of
which you speak (unless you're just paraphrasing).

if i deselect 8xx_UART, i'm assuming you're talking about going then
to the menu selections:

   Device Drivers
     Character devices
       Serial drivers

and selecting the appropriate CONFIG_SERIAL_CPM* settings (_SCC1 and
_SMC1)?  is that what you're referring to above?

   i may have to wait for one of the board experts to get in later to
make sure i have the right settings here.  thanks so far.

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
