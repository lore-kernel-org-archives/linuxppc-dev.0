Date: Thu, 20 Jun 2002 08:18:00 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Samuel Rydh <samuel@ibrium.se>, linuxppc-dev@lists.linuxppc.org
Subject: Re: sycall asm inline
Message-ID: <20020620151800.GC16052@opus.bloom.county>
References: <20020619033923.14394@smtp.wanadoo.fr> <Pine.LNX.4.33.0206201520090.15378-100000@gra-lx1.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.33.0206201520090.15378-100000@gra-lx1.iram.es>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jun 20, 2002 at 03:46:01PM +0200, Gabriel Paubert wrote:

> Note that I suspect that the compiler version check can be removed,
> everybody should be at 2.95 or later now. The change in letters for
> immediate constraint was quite painful.

Version checks for 2.4 are still probably a good idea (although I forget
if I removed one in 2.4 or 2.5, if it was 2.4, then disregard this. :))
but probably fine for 2.5 (although 2.5 _has to_ compile with egcs-1.1.2
for sparc for some reason..)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
