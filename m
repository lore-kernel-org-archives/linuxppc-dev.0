Date: Tue, 29 Jun 2004 12:59:21 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: ok ... which source trees are the "right" choices?
Message-ID: <20040629195920.GL28128@smtp.west.cox.net>
References: <Pine.LNX.4.60.0406291107530.25353@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.60.0406291107530.25353@localhost.localdomain>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jun 29, 2004 at 11:12:16AM -0400, Robert P. J. Day wrote:

>
>   based on wolfgang's recent reference to the linuxppc_2_4_devel
> source tree at DENX, one has to ask -- how does one choose between the
> various source trees to stay on top of things?

First, as far as I'm concerned, 2.4 is a low priority.  I'll forward
patches on to Marcelo, but quite frankly, I don't see the point of
trying to maintain additional trees (esp. given that most people looking
for a public tree want DENX's tree).  There _shouldn't_ be anything
in the ppc.bkbits.net 2.4 trees that's not in stock kernel.org (if it
is, it's almsot certainly in the DENX tree), but if there is, as I said,
I'll pass things along.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
