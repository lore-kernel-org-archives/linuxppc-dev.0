From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15869.5023.549830.146265@argo.ozlabs.ibm.com>
Date: Mon, 16 Dec 2002 10:43:27 +1100
To: Cort Dougan <cort@fsmlabs.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Support for Arctic platform (405LP based)
In-Reply-To: <20021215121526.M30941@duath.fsmlabs.com>
References: <20021213043628.GI21319@zax.zax>
	<20021212215126.V23952@duath.fsmlabs.com>
	<20021213151808.GI19456@opus.bloom.county>
	<20021215121526.M30941@duath.fsmlabs.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Cort Dougan writes:

> How about killing the _2_4_devel tree?  When I created it I want it to be a
> playground for stabilizing then moving things over to 2_4 failry quickly.
> It seems to have become the defacto "want board X, you better use
> _2_4_devel" tree.

Now that Marcelo is using BK, what I would really like to do is to
kill both the linuxppc_2_4 and linuxppc_2_4_devel trees and move to a
tree that is a child of Marcelo's linux-2.4 tree.

> When I went looking for a working 4xx tree recently I had to write a script
> that would go through the last year of changesets in _2_4 and _2_4_devel
> and try to build them then stick the result into a file.  That ran for 7
> days on a 2.0Ghz Dual x86.  Then, that only gave me a list of building
> trees.  Knowing that there's only 1 tree would be much easier!

4xx in particular is a problem because I'm not convinced about the
approach that has been taken for some of the 4xx infrastructure.  The
ocp stuff seems a lot more complicated than it needs to be, for
instance.  There is no particular reason that I can see why the 8xx
stuff in 2_4_devel shouldn't go to Marcelo for 2.4.21.

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
