Date: Mon, 19 Jan 2004 18:42:13 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
	Paul Mackerras <paulus@samba.org>
Subject: Re: linuxppc trees, what is going on ?
In-Reply-To: <20040119173000.GA24440@iliana>
Message-ID: <Pine.GSO.4.58.0401191839350.551@waterleaf.sonytel.be>
References: <20040113171827.GA13841@iliana> <20040113173513.GE10912@stop.crashing.org>
 <20040118122134.GA4994@iliana> <20040119152954.GD13454@stop.crashing.org>
 <20040119154758.GA23038@iliana> <20040119155801.GF13454@stop.crashing.org>
 <20040119163857.GB23613@iliana> <20040119164849.GG13454@stop.crashing.org>
 <20040119170741.GA23943@iliana> <20040119172251.GH13454@stop.crashing.org>
 <20040119173000.GA24440@iliana>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 19 Jan 2004, Sven Luther wrote:
> On Mon, Jan 19, 2004 at 10:22:51AM -0700, Tom Rini wrote:
> > > Yeah, but the point is, i am not sure if i am the person most
> > > appropriate to checking which of all those changeset are needed or not.
> > > A proper tagging would be much more appropriate, and make for easy
> > > reference when getting feedback and such.
> >
> > A proper tagging, for distribution use, isn't possible 100% of the time.
> > For example, if the tree goes from v2.4.29 to v2.4.30-pre1 to
> > v2.4.30-pre2 all while myself/Paul/Ben are on vacation, theres no way
> > to bring the bitkeeper tree, as of v2.4.30-pre1 and v2.4.30-pre2 into
> > linuxppc-2.4 and make a tag for each.  Likewise, if we don't grab the
> > bitkeeper tree at exactly v2.4.30-pre2, we can't make a tag that
> > corresponds to exactly that.
>
> Ohh. So this should be attributed to bitkeeper brokeness then ?

You can still clone Marcelo's tree at the label you want, and pull in
changes from the `old' (from last week) ppc tree, and label that.

I.e. if today Marcelo is at 2.4.25-pre6, while the ppc tree is at
2.4.25-pre1, and you want 2.4.25-pre2 for ppc, you can do this:
  - clone Marcelo's tree at 2.4.25-pre2
  - pull from ppc 2.4.25-pre1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
