Date: Mon, 19 Jan 2004 18:30:00 +0100
To: Tom Rini <trini@kernel.crashing.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	linuxppc-dev@lists.linuxppc.org, Paul Mackerras <paulus@samba.org>
Subject: Re: linuxppc trees, what is going on ?
Message-ID: <20040119173000.GA24440@iliana>
References: <20040113171827.GA13841@iliana> <20040113173513.GE10912@stop.crashing.org> <20040118122134.GA4994@iliana> <20040119152954.GD13454@stop.crashing.org> <20040119154758.GA23038@iliana> <20040119155801.GF13454@stop.crashing.org> <20040119163857.GB23613@iliana> <20040119164849.GG13454@stop.crashing.org> <20040119170741.GA23943@iliana> <20040119172251.GH13454@stop.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20040119172251.GH13454@stop.crashing.org>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jan 19, 2004 at 10:22:51AM -0700, Tom Rini wrote:
> > Yeah, but the point is, i am not sure if i am the person most
> > appropriate to checking which of all those changeset are needed or not.
> > A proper tagging would be much more appropriate, and make for easy
> > reference when getting feedback and such.
>
> A proper tagging, for distribution use, isn't possible 100% of the time.
> For example, if the tree goes from v2.4.29 to v2.4.30-pre1 to
> v2.4.30-pre2 all while myself/Paul/Ben are on vacation, theres no way
> to bring the bitkeeper tree, as of v2.4.30-pre1 and v2.4.30-pre2 into
> linuxppc-2.4 and make a tag for each.  Likewise, if we don't grab the
> bitkeeper tree at exactly v2.4.30-pre2, we can't make a tag that
> corresponds to exactly that.

Ohh. So this should be attributed to bitkeeper brokeness then ?

> On the other hand, it's not that hard to decide which changes are
> appropriate and which are not.  Using the real example of v2.4.24, all
> of the changes inbetween are for generic things, or possibly ppc64.  All
> of those can be backed out.

Yeah, but ideally, all distribution maintainers should use the same set
of changelogs for what should be considered

> <hat=former LinuxPPC, Inc kernel packaging guy>
> We all started digging into the kernel someplace :)
> </hat>.

Yeah. The problem i have is that most people which use my debian
packages use pmac, and i can't test it on those, since i don't have this
hardware. Oh, well, now that i understand things better, i will try to
go sorting the changesets or something. But still, a tag would be
welcome.

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
