Date: Tue, 13 Jan 2004 10:35:14 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: linuxppc trees, what is going on ?
Message-ID: <20040113173513.GE10912@stop.crashing.org>
References: <20040110084155.GA19817@iliana> <16385.63143.132872.395486@cargo.ozlabs.ibm.com> <20040112073217.GC20938@iliana> <20040113170631.GD10912@stop.crashing.org> <20040113171827.GA13841@iliana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040113171827.GA13841@iliana>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jan 13, 2004 at 06:18:27PM +0100, Sven Luther wrote:
> On Tue, Jan 13, 2004 at 10:06:31AM -0700, Tom Rini wrote:
> > On Mon, Jan 12, 2004 at 08:32:17AM +0100, Sven Luther wrote:
> >
> > > Ok, anyway linuxppc_2_4 is supposed to be dead. But my point was, from
> > > which TAG should i extract kernels from the linuxppc-2.4 to make debian
> > > packages ? I tried the v2.4.24 tag, which seemed ok, but the version was
> > > still 2.4.24-rc1. I guess this was a problem due to the haste of the
> > > 2.4.24 release or something, but it would be nice if it was clear which
> > > tag we should export.
> >
> > There is no tag you can use to do this.  Just like how 'v2.4.24' in the
> > old linuxppc_2_4* trees would get you 2.4.24 w/o any PPC changes, the
> > same will happen here.
>
> This is getting more complicated ...
>
> Ok, let's say, tomorrow i need to release a debian 2.4.24 powerpc
> package, what should i take for this, and which tag/date/whatever should
> i use.

First, do a bk help changes.  I mention this since I believe the
behavior of -e will change, or has changed.  Then do a 'bk changes' such
that you see all merge changesets.  Then just find that one that
corresponds to when the merge of Marcelo's tree that contained at least
v2.4.24 came in.  If there are changes after v2.4.24, you will have to
back these out from your patch manually (filterdiff or interdiff can probably
help here).

Paul, do you want to start adding tags to the linuxppc-2.4 tree?

> Also, there is the fact that modern powermac will most probably need
> stuff from the -benh tree, and that it would be maybe nicer for me to
> follow that tree instead.

The same applies here, except it's when linuxppc-2.4 that has v2.4.24 is
merged in.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
