Date: Fri, 15 Feb 2002 10:36:19 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Larry McVoy <lm@bitmover.com>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.5 development
Message-ID: <20020215173619.GN2004@opus.bloom.county>
References: <15468.64269.8252.644104@argo.ozlabs.ibm.com> <20020215085812.Z8353@work.bitmover.com> <20020215173210.GM2004@opus.bloom.county> <20020215093350.K8353@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020215093350.K8353@work.bitmover.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Feb 15, 2002 at 09:33:50AM -0800, Larry McVoy wrote:
> On Fri, Feb 15, 2002 at 10:32:10AM -0700, Tom Rini wrote:
> > On Fri, Feb 15, 2002 at 08:58:12AM -0800, Larry McVoy wrote:
> > >
> > > On Fri, Feb 15, 2002 at 11:11:57PM +1100, Paul Mackerras wrote:
> > > > The current limitations of BK mean that we will not be able to take
> > > > changesets directly from the linuxppc-2.5 tree and send them to
> > > > Linus.
> > >
> > > You can export changes as a patch and import them.
> >
> > Which still isn't directly. :)  It will catch most of the problems, but
> > if you export a patch with new files from one tree, import into another
> > and pull back into the original, you have a file conflict, yes?
>
> Yes, but that's not what we are talking about.  We're talking about
> export/import from two "unrelated" BK trees.  You can't pull unrelated
> trees at all.

These are related trees.  For 2.5.x all of the PPC trees are related to
the official Linus 2.5.x bk tree.  Something like:
linux-2.5 -> {for-linus-*, linuxppc-2.5}.
Since linuxppc-2.5 and for-linus-ppc are both children of linux-2.5,
shouldn't they be related?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
