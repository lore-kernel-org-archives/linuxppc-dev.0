Date: Fri, 13 Dec 2002 08:28:26 -0700
From: Matt Porter <porter@cox.net>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Cort Dougan <cort@fsmlabs.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Support for Arctic platform (405LP based)
Message-ID: <20021213082826.A7709@home.com>
References: <20021213043628.GI21319@zax.zax> <20021212215126.V23952@duath.fsmlabs.com> <20021213151808.GI19456@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021213151808.GI19456@opus.bloom.county>; from trini@kernel.crashing.org on Fri, Dec 13, 2002 at 08:18:08AM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Dec 13, 2002 at 08:18:08AM -0700, Tom Rini wrote:
>
> On Thu, Dec 12, 2002 at 09:51:26PM -0700, Cort Dougan wrote:
>
> > Would you be able to commit them to _2_4 instead so they're not in the
> > wildly divergent _2_4_devel tree?  That would definitely be handy when
> > trying to find where the working trees are.
>
> One of my goals for winter break is to try and make the _devel tree less
> divergent, at least w.r.t. 'classic' PPCs.  I'm not sure if 4xx support
> is in a stage yet that Paul is happy to move it to the _2_4 tree and
> then on to Marcelo yet.

At a minimum, the 4xx DBCR handling via thread struct would need to
be finished to make Paul happy, I believe.  Luckily, I don't need
a debugger so I've had no reason to finish the task that he left
"as an exercise for the reader".

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
