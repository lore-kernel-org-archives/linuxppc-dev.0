Date: Fri, 23 Jan 2004 08:49:45 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Larry McVoy <lm@work.bitmover.com>,
	Sven Luther <sven.luther@wanadoo.fr>,
	linuxppc-dev@lists.linuxppc.org, Paul Mackerras <paulus@samba.org>,
	bitkeeper-users@bitmover.com
Subject: Re: linuxppc trees, what is going on ?
Message-ID: <20040123154945.GV15271@stop.crashing.org>
References: <20040119152954.GD13454@stop.crashing.org> <20040119154758.GA23038@iliana> <20040119155801.GF13454@stop.crashing.org> <20040119163857.GB23613@iliana> <20040119164849.GG13454@stop.crashing.org> <20040119170741.GA23943@iliana> <20040119172251.GH13454@stop.crashing.org> <20040119173000.GA24440@iliana> <20040119174330.GI13454@stop.crashing.org> <20040123154058.GA15605@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040123154058.GA15605@work.bitmover.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jan 23, 2004 at 07:40:58AM -0800, Larry McVoy wrote:
> On Mon, Jan 19, 2004 at 10:43:30AM -0700, Tom Rini wrote:
> > On Mon, Jan 19, 2004 at 06:30:00PM +0100, Sven Luther wrote:
> > > On Mon, Jan 19, 2004 at 10:22:51AM -0700, Tom Rini wrote:
> > > > > Yeah, but the point is, i am not sure if i am the person most
> > > > > appropriate to checking which of all those changeset are needed or not.
> > > > > A proper tagging would be much more appropriate, and make for easy
> > > > > reference when getting feedback and such.
> > > >
> > > > A proper tagging, for distribution use, isn't possible 100% of the time.
> > > > For example, if the tree goes from v2.4.29 to v2.4.30-pre1 to
> > > > v2.4.30-pre2 all while myself/Paul/Ben are on vacation, theres no way
> > > > to bring the bitkeeper tree, as of v2.4.30-pre1 and v2.4.30-pre2 into
> > > > linuxppc-2.4 and make a tag for each.  Likewise, if we don't grab the
> > > > bitkeeper tree at exactly v2.4.30-pre2, we can't make a tag that
> > > > corresponds to exactly that.
> > >
> > > Ohh. So this should be attributed to bitkeeper brokeness then ?
> >
> > I think it's just a design issue.  You can't export as a bitkeeper tree
> > a bitkeeper tree at a given revision because it would be too much work,
> > or something.  I don't know for certain.  Can anyone on the
> > bitkeepr-users list shed some light on why there's no 'bk export -tbk' ?
> > Or is there a functional equivalent that I don't know?
>
> I don't know what it is that you are trying to do but I can guess.
>
> Regardless, the reason there is no 'bk export -tbk' is because it is not
> a feature that most people find useful.  I suspect that this is something
> that is more interesting to the open source folks than the commercial
> folks and if that is the case it isn't going to get fixed unless
> someone convinces their management to fund the change.  We're willing
> to do just about anything you want if you can foot the engineering NRE.

It turns out I just forgot about 'bk clone -rXXXX' which, at least in
my mind is equivalent to 'bk export -tbk -rXXXX'.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
