Date: Tue, 2 Apr 2002 16:20:48 -0700
From: Matt Porter <mporter@mvista.com>
To: andrew may <acmay@acmay.homeip.net>
Cc: Matt Porter <mporter@mvista.com>,
	Eugene Surovegin <ebs@innocent.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Status of 440GP port
Message-ID: <20020402232048.GF20767@beef.az.mvista.com>
References: <5.1.0.14.2.20020402113518.02aa3800@pop.prodigy.net> <20020402141845.A12269@home.com> <20020402134109.A5189@ecam.san.rr.com> <20020402222147.GE20767@beef.az.mvista.com> <20020402145400.B5189@ecam.san.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020402145400.B5189@ecam.san.rr.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Apr 02, 2002 at 02:54:00PM -0800, andrew may wrote:
> On Tue, Apr 02, 2002 at 03:21:47PM -0700, Matt Porter wrote:
> > On Tue, Apr 02, 2002 at 01:41:09PM -0800, andrew may wrote:
> > > On Tue, Apr 02, 2002 at 02:18:45PM -0700, Matt Porter wrote:
> > > >
> > > > On Tue, Apr 02, 2002 at 11:46:12AM -0800, Eugene Surovegin wrote:
> > > >
> > > > I wouldn't say it has been underway for "quite some time".  4-5 working
> > > > weeks is a short amount of development time for a new processor (at least
> > > > for me). :)
> > >
> > > So are you useing your own repository to track your development? It sure
> > > doesn't seem like the 2_4_devel tree is a development tree anymore. And
> > > seeing how hard it has become to get changes into the "devel" tree also
> > > suggests that the tree is not really a development tree.
> >
> > Hrm.  I've simply not checked in any files to my local _devel clone.
> > Unlike other developers, I choose not to push in non-tested and/or
> > non-working bits.  I can't comment on your problems with getting
> > changes in the _devel tree since I've only recently started following
> > the 4xx conversations and have never been involved with 4xx until
> > a little while ago.
>
> I would expect a development tree to contain non-working and non-tested
> stuff. It becomes very help full to see things that get tried but don't
> work in the history of a file. It makes a lot more sense to use the version
> history to document quirks in hardware than to start putting comments in the
> source on what does and doesn't work.

So I don't use the tool the way you do.  That's the granularity I might
normally use for local checkins, but we've never really had that kind
of granularity on _devel pushes.  It's not used that way.

> I would sure not want to work for 4-5 weeks between pushes. I like to be
> able to make dangerous changes to code knowing that I can always fall back
> to a few day older version that sort-of worked.

Local backups, .origs, local checkins.  Again, different style of
development.  Luckily, nobody yet controls how develop on my own
machine.  4-5 weeks is just a one time initial seed of a starting
point.

> > > Any particular reason you are keeping things "close to your chest"? I know
> > > it is nice to be able to go through and makes changes where ever you
> > > like without having to be confronted with them every checkin/merge, but
> > > since there are change that will at least change the file structure of
> > > other boards it seems like it should be kept more in the open.
> >
> > The first pass of the core 440 support has no changes that affect the
> > file structure of other boards (assuming you are concerned about 40x).
> > Again, this is I how do _devel work...I code some logical set of
> > functionality (in this case core + onboard serial/emac), make sure it's
> > pretty enough that I'm not embarassed, and then I push it out.  I've
> > also been asked not to push until paulus is satisfied with the low-level
> > booke support.
>
> I am sure most of us are understanding of potentially embarrassing code
> and we may just lend a hand cleaning things up. It seems like a lot
> of embarrassing code slips past people when it just works.

It's actually more like FIXME reminders of hardcoded addresses and
stuff that would cause me too much time explaining to hoards of
people wanting a 440 port to play with.

> > In my years of contributing to Linux/PPC, this is the first time I've
> > had someone question how/when I contribute my work back.  I've always
> > pushed stuff out as soon as it makes sense.
>
> It looks like Eugene wants to help try things out and he has hardware
> and as long as you are the only one with the source he can either wait
> or start redoing what you have already done.

Those are the options.  I'll make it available when it makes sense
to open the floodgates of bug reports.

> In the past it may have been MVista got boards ahead of the rest of the
> market, but it seems like the boards are hitting the rest of the world
> the same time you get them. If some of those people with the boards
> are capable of helping to bring them up or cleaning up the source (think
> kernel janitors), then it starts to make sense to push stuff out as
> soon as it is written.

I'm looking forward to having lots of eyeballs on it...this is not a
new concept to me, thanks.

Regards,
--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
