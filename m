To: brian.auld@adic.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linuxppc_2_4_devel from denx vs. bitkeeper 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 21 Feb 2003 08:02:52 PST."
             <995FF289C9D69747A09E42992644595405B2367D@penguin.adic.com>
Date: Fri, 21 Feb 2003 18:30:00 +0100
Message-Id: <20030221173005.B7EA1C6E0D@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear brian,

in message <995FF289C9D69747A09E42992644595405B2367D@penguin.adic.com> you wrote:
>
> Question: What is the difference between using the kernel source found at
> the denx website, versus cloning/rsynching directly from the root

The difference is that we are free to put any stuff we like onto  our
CVS  server, but to make something go into the "official" source tree
is often a time-consuming and frstrating experience.

[I don't want to start a lengthy  discussion  again.  I  pretty  well
understand the reasons why things are as they are.]

> Going forward, I want to have (a) a kernel that compiles and (b) a
> relatively easy way to rsynch any desired updates into my kernel in a
> relatively painless manner.

Use bk (and probably CVS) ;-)

> My current throught is to use bkbits and modify the Makefile according to
> DENX in my local custom kernel branch. I can then rsync according to bkbits
> updates as opposed to using the DENX source ... which seems to use a
> combination of CVS and BK.

We use CVS only for all of our work, but we are forced  to  pull  the
sources from the BK archives.

> Are there other differences (i.e. adding functionality) provided by DENX
> that would make me want to use the DENX source instead? That's my basic
> question.

You can expect to find bug fixes, extensions, board support and other
things in our version of the kernel source that will  never  make  it
into  the official tree for one reason or another. I don't like this,
but I cannot change it either. It's just  the  way  that  causes  the
smallest effort on our side. If we come up with an updated version of
a  driver it is a matter of minutes to check it into CVS. But it will
take hours and hours to break in up into all the atomic modifications
that I can submit as patches to the official kernel - and normally  I
also  should  test  all these little steps, too. Usually I don;t have
the time to do that, and not the patience either.

> p.s. I've been trying to understand what potential differences there are
> between the 2 kernel trees by diffing specific releases ... but with the
> DENX source being CVS controlled and the root repo being bk controlled, I'm
> having a tough time, even after sucking out the CVS and SCCS dirs.

Why? You can "bk export" one tree, and "cvs export"  the  other  one,
and then run "diff". Or you can generate the diff's only from our CVS
tree.  There  are  tagged  versions  which  clearly indicate which BK
changeset they correspond to. Also note the BK.KEY file in our  tree,
which summarizes this.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
It's hard to make a program foolproof because fools are so ingenious.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
