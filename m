Date: Fri, 19 Oct 2001 09:28:53 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Larry McVoy <lm@bitmover.com>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.linuxppc.org, tytso@thunk.org
Subject: Re: Renames, BK, PPC, etc
Message-ID: <20011019092853.A10163@cpe-24-221-152-185.az.sprintbbd.net>
References: <15312.6740.808012.183783@cargo.ozlabs.ibm.com> <20011019081353.C7765@cpe-24-221-152-185.az.sprintbbd.net> <20011019081649.A17049@work.bitmover.com> <20011019083430.D7765@cpe-24-221-152-185.az.sprintbbd.net> <20011019091645.B17049@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011019091645.B17049@work.bitmover.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Oct 19, 2001 at 09:16:45AM -0700, Larry McVoy wrote:

> The question is this: if Linus & Co were to start using BK, does anyone
> here care whether it is the current PPC maintained tree or are you willing
> to start over?  BK is not going to let you pull from the new tree to your
> current tree, as far as BK is concerned those are completely unrelated
> repositories.  So you'd have to switch.

Well, I guess part of the question/problem is how easy is it to keep one
of the trees up to date?  We still haven't decided what to do for 2.5
yet (I'd like to for linux_2_4 and keep going w/ the _devel tree as a
2_5 tree, but that's just me probably.)  If Ted's tree is reasonably up
to date (or it'd be possible for myself/Paul to help keep it so), I
wouldn't be opposed to trying linuxppc_2_5 as a subtree of Ted's.

> If you haven't been maintaining the renames all along and there is lots
> of crud in the tree, then I can see you not caring at all.  In fact, it
> would probably be desirable to do a reset.  Paul?  Cort?  Others?

I don't think the crud is hurting much tho..  I'd rather keep history,
but I'm also not opposed to change. :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
