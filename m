Date: Fri, 14 Mar 2003 21:56:36 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: ppc: Update to ppc specific makefiles
Message-ID: <20030314205636.GA28130@mars.ravnborg.org>
References: <20030314194427.GA18790@mars.ravnborg.org> <20030314202148.GA7230@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030314202148.GA7230@ip68-0-152-218.tc.ph.cox.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Mar 14, 2003 at 01:21:48PM -0700, Tom Rini wrote:
[Tom's original reply will not show up at linuxppc-dev becasue my initial
mail contained the wrong address, and I just bounced it to linuxppc-dev]

> > The kernel builds and when a rebuild is made no files are compiled again.
> > arch/ppc/boot/{openfirmware,prep,simple}/Makefile could use more
> > attention - but wanted to see this applied first.
>
> I'm open to ideas for how to clean those up.  Please CC me with those
> (I'll read it quicker, most likley :)

I will give the most simple one a spin then [prep].
Hold on applying this for a while.

> Maybe I'm missing something, but won't this cause all of host-progs to
> be compiled on any build?  They're small / quick enough to build that I
> suppose it wouldn't kill anyone to build extra tools they don't need,
> but in that case, the tools- stuff could die in arch/ppc/boot/Makefile,
> right?

It is rather me who missed something I'm afraid.
The Makefile in ppc/boot/utils is not needed at all and can be deleted.
The "host-prog := " in ppc/boot/Makefile is all what is needed.
[tools/ shall be removed from subdir- := in boot/makefile]

I would like to delete all the tool selection stuff in boot/Makefile.
As you say it does not matter for the total build time.
OK with you?

	Sam

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
