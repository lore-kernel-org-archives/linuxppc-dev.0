Date: Sun, 7 May 2000 23:49:16 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
To: Daniel Jacobowitz <drow@false.org>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: problem with Makefile
In-Reply-To: <20000508014714.A19467@drow.res.cmu.edu>
Message-ID: <Pine.LNX.3.96.1000507234646.3380B-100000@deepspace.mklinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 8 May 2000, Daniel Jacobowitz wrote:

> On Mon, May 08, 2000 at 01:26:05PM +0800, Rolf Liu wrote:
> >
> > current work
> > is to translate the Makefile of linux-ppc into a standard one, such as one
> > for windows-based
> > Makefile,which is meaningful to other standard "make" utilities,including
>
> There is a standard make.  It's POSIX, I believe.  The linux makefile
> is pretty close to it.  Why on earth would you want to use Microsoft or
> Borland tools (which are nmake, not make, IIRC) to build a kernel?

As a fun exercise?

Seriously, though, what would be good would be to modify the makefile to
eliminate all gnu extensions, i.e. converting it into a pure lowest-
common-denominator makefile (yes, it's probably POSIX).  That would allow
it to be built under other OSes, including Windoze, but also *BSD, Darwin,
MacOS X, etc.  That having been said, it's a pain in the backside to do
that sort of thing, so I wish you lots of luck.  ;-)


David

---------------------------------------------------------------------
Let's make a virus that spreads through Outlook and Outlook Express
that opens MSIE and points it at a page that says "Your Email Program
is prone to viruses" with a link to the pine home page.
    -- Me


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
