Date: Wed, 14 Jan 2004 09:55:06 +0100
To: Tom Rini <trini@kernel.crashing.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	linuxppc-dev@lists.linuxppc.org, Paul Mackerras <paulus@samba.org>
Subject: Re: linuxppc trees, what is going on ?
Message-ID: <20040114085506.GA25451@iliana>
References: <20040110084155.GA19817@iliana> <16385.63143.132872.395486@cargo.ozlabs.ibm.com> <20040112073217.GC20938@iliana> <20040113170631.GD10912@stop.crashing.org> <20040113171827.GA13841@iliana> <20040113173513.GE10912@stop.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20040113173513.GE10912@stop.crashing.org>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jan 13, 2004 at 10:35:14AM -0700, Tom Rini wrote:
>
> On Tue, Jan 13, 2004 at 06:18:27PM +0100, Sven Luther wrote:
> > On Tue, Jan 13, 2004 at 10:06:31AM -0700, Tom Rini wrote:
> > > On Mon, Jan 12, 2004 at 08:32:17AM +0100, Sven Luther wrote:
> > >
> > > > Ok, anyway linuxppc_2_4 is supposed to be dead. But my point was, from
> > > > which TAG should i extract kernels from the linuxppc-2.4 to make debian
> > > > packages ? I tried the v2.4.24 tag, which seemed ok, but the version was
> > > > still 2.4.24-rc1. I guess this was a problem due to the haste of the
> > > > 2.4.24 release or something, but it would be nice if it was clear which
> > > > tag we should export.
> > >
> > > There is no tag you can use to do this.  Just like how 'v2.4.24' in the
> > > old linuxppc_2_4* trees would get you 2.4.24 w/o any PPC changes, the
> > > same will happen here.
> >
> > This is getting more complicated ...
> >
> > Ok, let's say, tomorrow i need to release a debian 2.4.24 powerpc
> > package, what should i take for this, and which tag/date/whatever should
> > i use.
>
> First, do a bk help changes.  I mention this since I believe the
> behavior of -e will change, or has changed.  Then do a 'bk changes' such
> that you see all merge changesets.  Then just find that one that
> corresponds to when the merge of Marcelo's tree that contained at least
> v2.4.24 came in.  If there are changes after v2.4.24, you will have to
> back these out from your patch manually (filterdiff or interdiff can probably
> help here).

Yep, i did this already in the past, didn't know about -e though, will
look.

> Paul, do you want to start adding tags to the linuxppc-2.4 tree?

Yes, that would be really practical. It would be really practical, and
it would not cost all that much in time for putting these tags, while
getting the right changeset to extract is time consuming and
error-prone. That said, maybe 2.4.24 was exceptional. But still, tags
would be welcome.

> > Also, there is the fact that modern powermac will most probably need
> > stuff from the -benh tree, and that it would be maybe nicer for me to
> > follow that tree instead.
>
> The same applies here, except it's when linuxppc-2.4 that has v2.4.24 is
> merged in.

Yep.

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
