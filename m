Date: Sun, 15 Dec 2002 12:51:00 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Cort Dougan <cort@fsmlabs.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Support for Arctic platform (405LP based)
Message-ID: <20021215195100.GB6095@opus.bloom.county>
References: <20021213043628.GI21319@zax.zax> <20021212215126.V23952@duath.fsmlabs.com> <20021213151808.GI19456@opus.bloom.county> <20021215121526.M30941@duath.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021215121526.M30941@duath.fsmlabs.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sun, Dec 15, 2002 at 12:15:26PM -0700, Cort Dougan wrote:

> How about killing the _2_4_devel tree?  When I created it I want it to be a
> playground for stabilizing then moving things over to 2_4 failry quickly.
> It seems to have become the defacto "want board X, you better use
> _2_4_devel" tree.

That's been the stated goal for quite a number of months now.  The
reason it hasn't 'died' yet is that some changes have taken a while to
get to the point where Paul is happy enough with them to send out to
Marcelo, and / or Marcelo has gotten far along in the -pre releases of
the next release that big arch specific changes aren't a good idea.

Hopefully starting the week of 12/23 I'll have time to get the 'classic'
PPC (and here it's really i8259 / OpenPIC stuff, the CPC700/CPC710
boards can / have gone out) to the _2_4 tree and onto Marcelo.

> When I went looking for a working 4xx tree recently I had to write a script
> that would go through the last year of changesets in _2_4 and _2_4_devel
> and try to build them then stick the result into a file.  That ran for 7
> days on a 2.0Ghz Dual x86.  Then, that only gave me a list of building
> trees.  Knowing that there's only 1 tree would be much easier!

4xx in and of itself has things which still need to be done.  The stock
answer for some time for a 'working' 4xx tree is to use _devel.  I think
that it might be possible to get the basics of 4xx out to Marcelo, if
some of the cleanups done in 2.5 get (a) finished and then (b)
backported to 2.4.  But that would still I suspect leave enet and other
things out at the moment.

> I'll send you some wonderful New Mexico wine in exchange for your efforts!

Woo! :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
