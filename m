Date: Fri, 15 Feb 2002 10:44:33 -0800
From: Larry McVoy <lm@bitmover.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Larry McVoy <lm@bitmover.com>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.5 development
Message-ID: <20020215104433.C28735@work.bitmover.com>
References: <15468.64269.8252.644104@argo.ozlabs.ibm.com> <20020215085812.Z8353@work.bitmover.com> <20020215173210.GM2004@opus.bloom.county> <20020215093350.K8353@work.bitmover.com> <20020215173619.GN2004@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020215173619.GN2004@opus.bloom.county>; from trini@kernel.crashing.org on Fri, Feb 15, 2002 at 10:36:19AM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> These are related trees.  For 2.5.x all of the PPC trees are related to
> the official Linus 2.5.x bk tree.  Something like:
> linux-2.5 -> {for-linus-*, linuxppc-2.5}.
> Since linuxppc-2.5 and for-linus-ppc are both children of linux-2.5,
> shouldn't they be related?

Yes, if they are all clones from the same original tree, they are all
related.  The way to tell is to run "bk identity" in each tree, if that
output is the same, you may pull between them.

I thought Paul was talking about taking changes from the tree Cort created
and putting it the tree Linus created.
--
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
