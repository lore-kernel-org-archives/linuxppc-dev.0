Date: Mon, 19 Jan 2004 18:07:41 +0100
To: Tom Rini <trini@kernel.crashing.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	linuxppc-dev@lists.linuxppc.org, Paul Mackerras <paulus@samba.org>
Subject: Re: linuxppc trees, what is going on ?
Message-ID: <20040119170741.GA23943@iliana>
References: <20040112073217.GC20938@iliana> <20040113170631.GD10912@stop.crashing.org> <20040113171827.GA13841@iliana> <20040113173513.GE10912@stop.crashing.org> <20040118122134.GA4994@iliana> <20040119152954.GD13454@stop.crashing.org> <20040119154758.GA23038@iliana> <20040119155801.GF13454@stop.crashing.org> <20040119163857.GB23613@iliana> <20040119164849.GG13454@stop.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20040119164849.GG13454@stop.crashing.org>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jan 19, 2004 at 09:48:50AM -0700, Tom Rini wrote:
>
> On Mon, Jan 19, 2004 at 05:38:57PM +0100, Sven Luther wrote:
> > On Mon, Jan 19, 2004 at 08:58:01AM -0700, Tom Rini wrote:
> > > On Mon, Jan 19, 2004 at 04:47:58PM +0100, Sven Luther wrote:
> > >
> > > > On Mon, Jan 19, 2004 at 08:29:54AM -0700, Tom Rini wrote:
> > > > > > I did pull the linux-2.4 tree, and exported the v2.4.24 tag. I did the
> > > > > > same for the linuxppc-2.4 tree, and diffed the two exported trees. Both
> > > > > > were exactly the same.
> > > > >
> > > > > That is correct. A tag has the same values (set of ChangeSets)
> > > > > regardless of the tree (simpilication).
> > > >
> > > > Ok, how are you then supposed to make a diff of the powerpc relative
> > > > changes ? You use the changeset just above the merge or something ?
> > >
> > > The process I described about (that you snipped) is how you find the
> > > ChangeSet of when 'linux-2.4' at a certain point is merged into
> > > 'linuxppc-2.4', and that ChangeSet will point to something like 2.4.24 +
> > > powerpc changes.
> >
> > Yeah, but i am not sure i fully understand. In this case, bk changes in
> > linuxppc-2.4 yields :
> >
> > ChangeSet@1.1058.1.312, 2004-01-04 19:34:56-02:00, marcelo@logos.cnet
> >   Import 2.4.24 final tree
> >
> > ChangeSet@1.1058.1.311, 2004-01-04 19:32:02-02:00, marcelo@logos.cnet
> >   Cset exclude: laforge@netfilter.org|ChangeSet|20031204183256|31723
> >
> > ChangeSet@1.1058.1.310, 2004-01-04 19:31:23-02:00, marcelo@logos.cnet
> >   Cset exclude: jt@bougret.hpl.hp.com|ChangeSet|20031213132008|01226
> >
> > ChangeSet@1.1058.1.309, 2004-01-04 19:31:05-02:00, marcelo@logos.cnet
> >   Cset exclude: trini@mvista.com|ChangeSet|20031210203050|36304
> >
> > ChangeSet@1.1058.1.308, 2004-01-04 19:28:46-02:00, marcelo@logos.cnet
> >   Cset exclude: bjorn.helgaas@hp.com|ChangeSet|20031218183339|13120
> >
> > ChangeSet@1.1058.235.6, 2004-01-04 17:53:50-02:00, marcelo@logos.cnet
> >   Change EXTRAVERSION to 2.4.24-rc1
> >   TAG: v2.4.24
> >   TAG: v2.4.24-rc1
> >
> > None of them seem related to when the linux-2.4 changeset got merged
> > into linuxppc-2.4.
>
> You also get:
> ChangeSet@1.1179.1.1, 2004-01-06 12:37:52-07:00, trini@kernel.crashing.org
>   Merge in recent changes by hand.

Oh.

> Which is as close to 2.4.24 + powerpc changes as you're going to get,
> automatically.  You can use 'bk export -tpatch' to back out the changes
> which follow that you don't want.

Yeah, but the point is, i am not sure if i am the person most
appropriate to checking which of all those changeset are needed or not.
A proper tagging would be much more appropriate, and make for easy
reference when getting feedback and such.

Anyway, i will see what i can do, thanks for your information, i think
now i understand what is going on.

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
