Date: Tue, 2 Apr 2002 16:28:16 -0800
From: andrew may <acmay@acmay.homeip.net>
To: Matt Porter <mporter@mvista.com>
Cc: andrew may <acmay@acmay.homeip.net>,
	Eugene Surovegin <ebs@innocent.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Status of 440GP port
Message-ID: <20020402162816.D5189@ecam.san.rr.com>
References: <5.1.0.14.2.20020402113518.02aa3800@pop.prodigy.net> <20020402141845.A12269@home.com> <20020402134109.A5189@ecam.san.rr.com> <20020402222147.GE20767@beef.az.mvista.com> <20020402145400.B5189@ecam.san.rr.com> <20020402232048.GF20767@beef.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020402232048.GF20767@beef.az.mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Apr 02, 2002 at 04:20:48PM -0700, Matt Porter wrote:
>
> On Tue, Apr 02, 2002 at 02:54:00PM -0800, andrew may wrote:
> > On Tue, Apr 02, 2002 at 03:21:47PM -0700, Matt Porter wrote:
> > > On Tue, Apr 02, 2002 at 01:41:09PM -0800, andrew may wrote:
> > > > On Tue, Apr 02, 2002 at 02:18:45PM -0700, Matt Porter wrote:
> > > > >
> > > > > On Tue, Apr 02, 2002 at 11:46:12AM -0800, Eugene Surovegin wrote:
> > > >
> > > > So are you useing your own repository to track your development? It sure
> > > > doesn't seem like the 2_4_devel tree is a development tree anymore. And

...

> So I don't use the tool the way you do.  That's the granularity I might
> normally use for local checkins, but we've never really had that kind
> of granularity on _devel pushes.  It's not used that way.

Well that would be my point, that _devel tree is not used for direct
development.

> > I would sure not want to work for 4-5 weeks between pushes. I like to be
> > able to make dangerous changes to code knowing that I can always fall back
> > to a few day older version that sort-of worked.
>
> Local backups, .origs, local checkins.  Again, different style of
> development.  Luckily, nobody yet controls how develop on my own
> machine.  4-5 weeks is just a one time initial seed of a starting
> point.

So that would be the answer to my first question of what you are useing
to track your own development. You didn't answer it the first time around
it would seem like you were using the _devl tree as your source control
method. I don't even use bitkeeper and I could care less if you did or not,
but I asked what you were using.

> Those are the options.  I'll make it available when it makes sense
> to open the floodgates of bug reports.

A bug report should never be written against a development tree. You can
always see a flood of problems on lkml, but most of them are just ignored
for being stupid user issues.

> I'm looking forward to having lots of eyeballs on it...this is not a
> new concept to me, thanks.

Well you seem to have the attitude that you are the only one that is
capable of working on things at the moment.

I would ask you to give some examples of people that are working on the Linux
kerenl that do 4-5 weeks of development without public review.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
