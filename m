Date: Wed, 9 Feb 2000 12:30:23 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Dan Bethe <dan_bethe@yahoo.com>
cc: Gabriel Ricard <g_ricard@yahoo.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: the state of the linuxppc-dev community
In-Reply-To: <20000208233505.29535.qmail@web1003.mail.yahoo.com>
Message-ID: <Pine.LNX.4.10.10002091152160.11080-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > So what exactly is the problem? The 2.2.12 source? The .config? The fact
> > that LinuxPPC developers appear to break the GPL by not dropping a fresh
> > source tarball along each kernel binary?
>
> 	I happen to know the problem shared by Gabe, me, and anyone else primarily
> concerned with the stability, robustness, and ease of use of the whole LinuxPPC
> distribution and community authority.
> 	The problem is that LinuxPPC.org has a development environment that is
> splintered, unstable, undocumented, obscure, nonintuitive, and basically
> impenetrable even to people who are fully dedicated to it such as Gabe and
> myself.  It is run almost exclusively on tribal knowledge that is only in the
> heads of the people who are writing the ppc-specific core of the OS.  There are
> no procedures and no interface.  And there is very little respect toward people
> like me and Gabe who have the time, dedication, and skills to clean it all up.

With all due respect: if that's what you wanted to direct our attention
to, you should have said so up front. I'm a bit over sensitzited to people
that wave the GPL argument in my face (being a Debian developer for m68k,
and seeing all the tribal infighting there). That's why I jumped all over
Gabe (your name sounds familiar from c.o.l.powerpc or this list, his
wasn't. Sorry for assuming this was just some moron posting flame bait.)

On the issue at hand: when I started working on PPC last year, I also
noticed that information about patches, kernels, people to talk and send
patches to was hard to find (I remember posting a complaint to that effect
to the NG). Having had some contact with Paul on m68k/PPC code sharing
issues before, I knew where to start asking at least, and sent a few
patches to Paul and BenH. Listening on this list for a while since gave me
a better overview on who's doing what, at least where kernel devlopment is
concerned.

I do see the problem that information is splintered over too many web
pages and FTP servers (I fail to see what this has to do with the GPL). I
would welcome having a central dsitribution independent site gather what's
out on the net, I'm too lazy to dig around for bits of information most of
the time myself. I fail to see how lack of response to your suggestions
(that I see voiced by you and Gabe for the first time now on this list)
constitutes lack of respect for you. I imagine keeping up with the project
at hand may leave little time for developers to think about procedures.
That doesn't mean nobody cares. It's not a high priority for some.

> 	First, obviously, we have to map out how everything currently is, before we
> could even suggest anything better.  But because 90% of the responses we get
> are either dead silence or asinine arguments like yours, we are slowly getting
> nowhere.  The remaining 10% are the responses of a mob cheering us on just for
> having pointed out the silly state of the maintenance of LinuxPPC.

The asinine argument was in reply to a post I perceived as asinine. I hope
you accept that as explanation, and let us move on. The resources I know
of are the FAQ-o-matic, mailing list and archive, c.o.l.powerpc (and
maybe deja archive), ftp.dev.linuxppc.org for all sorts of kernel and user
space updates, rsync servers for stable and development trees, and the
linuxppc.org web site that links to few of the above in no particularly
logical fashion.

I could imagine a reworked web site, plus CVS or other access to the
sources would be a good start. I agree with Tony Mantler on the importance
of CVS - having run the m68k Mac port almost as one-man-show for a year,
switching to CVS encouraged at least five more people to start working on
various parts. Getting the latest sources without waiting for me
to build a new diff, checking in patches directly and improved
communication were instrumental in advancing development.

> 	We have definately produced deeds rather than just words.  Gabe is a primary
> maintainer of Stampede Linux (www.stampede.org), and is working on porting
> Stampede to PPC; and I've accepted jhaas's request to be the primary maintainer
> of LinuxPPC security and of LinuxPPC Powerbook support.  We both use LinuxPPC
> on Powerbook for 99% of our daily work.

More power to you. I hope you can get some of your suggestions on
improving the communication and infrastructure and organizing the
PPC port adopted here. Please keep in mind that not all of us are
'professionals' though. I use LinuxPPC (on a Powerbook) for my daily work,
but I can work on the kernel source only in my spare time, as an amateur.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
