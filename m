Date: Mon, 19 Jan 2004 08:58:01 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: linuxppc trees, what is going on ?
Message-ID: <20040119155801.GF13454@stop.crashing.org>
References: <20040110084155.GA19817@iliana> <16385.63143.132872.395486@cargo.ozlabs.ibm.com> <20040112073217.GC20938@iliana> <20040113170631.GD10912@stop.crashing.org> <20040113171827.GA13841@iliana> <20040113173513.GE10912@stop.crashing.org> <20040118122134.GA4994@iliana> <20040119152954.GD13454@stop.crashing.org> <20040119154758.GA23038@iliana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040119154758.GA23038@iliana>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jan 19, 2004 at 04:47:58PM +0100, Sven Luther wrote:

> On Mon, Jan 19, 2004 at 08:29:54AM -0700, Tom Rini wrote:
> > > I did pull the linux-2.4 tree, and exported the v2.4.24 tag. I did the
> > > same for the linuxppc-2.4 tree, and diffed the two exported trees. Both
> > > were exactly the same.
> >
> > That is correct. A tag has the same values (set of ChangeSets)
> > regardless of the tree (simpilication).
>
> Ok, how are you then supposed to make a diff of the powerpc relative
> changes ? You use the changeset just above the merge or something ?

The process I described about (that you snipped) is how you find the
ChangeSet of when 'linux-2.4' at a certain point is merged into
'linuxppc-2.4', and that ChangeSet will point to something like 2.4.24 +
powerpc changes.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
