Date: Fri, 13 Dec 2002 08:16:43 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Gary Thomas <gary@mlbassoc.com>
Cc: Cort Dougan <cort@fsmlabs.com>,
	linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Support for Arctic platform (405LP based)
Message-ID: <20021213151642.GH19456@opus.bloom.county>
References: <20021213043628.GI21319@zax.zax> <20021212215126.V23952@duath.fsmlabs.com> <1039789562.7542.14781.camel@hermes.chez-thomas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1039789562.7542.14781.camel@hermes.chez-thomas.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Dec 13, 2002 at 07:26:02AM -0700, Gary Thomas wrote:

> On Thu, 2002-12-12 at 21:51, Cort Dougan wrote:
> >
> > Would you be able to commit them to _2_4 instead so they're not in the
> > wildly divergent _2_4_devel tree?  That would definitely be handy when
> > trying to find where the working trees are.
> >
> > } The patch below adds support for IBM's Arctic-II development system,
> > } based on the 405LP processor.  For now this is just the core support,
> > } more drivers coming soon.  Are there any objections, or suggestions
> > } for doing things better before I commit this to linuxppc_2_4_devel?
> > }
>
> This brings up some really good questions.  I have support for three new
> platforms based on the _2_4_devel tree which I'd like to get submitted
> soon [so far, I've just been following along]  So,
>  * Which tree should be best for new development/ports/etc?

The _2_4_devel tree at the moment, since that still has generally better
infrastructure for non-pmacs :)  I would also like to see a patch
against the current linuxppc-2.5 tree as well.  It doesn't have to be as
well tested as the 2_4_devel version, and if the tree as a whole doesn't
compile at the time, make a/b/c.o is actually legal in 2.5 so just make
sure your changes still compile.

>  * What's the best process for proposing changes?  I've seen many
>    patches come along on this list, but it's not clear to me if/when
>    they made it to any particular tree.

If you aren't already on the linuxppc-commit@source.mvista.com list, you
might want to join that.  If a change makes it into any of the
linuxppc_* lists, a msg gets sent there.  If you want to propose a
change cc relevant people (generally Paul and / or myself) and send it
to the linuxppc-dev and / or linuxppc-embedded lists.  Someone will
speak up, even if it's only me to say I'm too busy today. :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
