From: Cort Dougan <cort@fsmlabs.com>
Date: Sun, 15 Dec 2002 12:15:26 -0700
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Support for Arctic platform (405LP based)
Message-ID: <20021215121526.M30941@duath.fsmlabs.com>
References: <20021213043628.GI21319@zax.zax> <20021212215126.V23952@duath.fsmlabs.com> <20021213151808.GI19456@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021213151808.GI19456@opus.bloom.county>; from trini@kernel.crashing.org on Fri, Dec 13, 2002 at 08:18:08AM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


How about killing the _2_4_devel tree?  When I created it I want it to be a
playground for stabilizing then moving things over to 2_4 failry quickly.
It seems to have become the defacto "want board X, you better use
_2_4_devel" tree.

When I went looking for a working 4xx tree recently I had to write a script
that would go through the last year of changesets in _2_4 and _2_4_devel
and try to build them then stick the result into a file.  That ran for 7
days on a 2.0Ghz Dual x86.  Then, that only gave me a list of building
trees.  Knowing that there's only 1 tree would be much easier!

I'll send you some wonderful New Mexico wine in exchange for your efforts!

} One of my goals for winter break is to try and make the _devel tree less
} divergent, at least w.r.t. 'classic' PPCs.  I'm not sure if 4xx support
} is in a stage yet that Paul is happy to move it to the _2_4 tree and
} then on to Marcelo yet.
}
} --
} Tom Rini (TR1265)
} http://gate.crashing.org/~trini/
}

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
