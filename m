Date: Tue, 2 Apr 2002 15:21:47 -0700
From: Matt Porter <mporter@mvista.com>
To: andrew may <acmay@acmay.homeip.net>
Cc: Matt Porter <mporter@mvista.com>,
	Eugene Surovegin <ebs@innocent.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Status of 440GP port
Message-ID: <20020402222147.GE20767@beef.az.mvista.com>
References: <5.1.0.14.2.20020402113518.02aa3800@pop.prodigy.net> <20020402141845.A12269@home.com> <20020402134109.A5189@ecam.san.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020402134109.A5189@ecam.san.rr.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Apr 02, 2002 at 01:41:09PM -0800, andrew may wrote:
> On Tue, Apr 02, 2002 at 02:18:45PM -0700, Matt Porter wrote:
> >
> > On Tue, Apr 02, 2002 at 11:46:12AM -0800, Eugene Surovegin wrote:
> > >
> > > I checked yesterday bk://ppc.bkserver.net/linuxppc_2_4_devel tree and found
> > > some preparations for this port (e.g. 4xx->40x renaming).
> >
> > There will be a few more preparation changes before the rest arrives.
> >
> > > I understand that this effort is under way for quite some time but not yet
> > > released (or am I wrong?).
> >
> > I wouldn't say it has been underway for "quite some time".  4-5 working
> > weeks is a short amount of development time for a new processor (at least
> > for me). :)
>
> So are you useing your own repository to track your development? It sure
> doesn't seem like the 2_4_devel tree is a development tree anymore. And
> seeing how hard it has become to get changes into the "devel" tree also
> suggests that the tree is not really a development tree.

Hrm.  I've simply not checked in any files to my local _devel clone.
Unlike other developers, I choose not to push in non-tested and/or
non-working bits.  I can't comment on your problems with getting
changes in the _devel tree since I've only recently started following
the 4xx conversations and have never been involved with 4xx until
a little while ago.

> Any particular reason you are keeping things "close to your chest"? I know
> it is nice to be able to go through and makes changes where ever you
> like without having to be confronted with them every checkin/merge, but
> since there are change that will at least change the file structure of
> other boards it seems like it should be kept more in the open.

The first pass of the core 440 support has no changes that affect the
file structure of other boards (assuming you are concerned about 40x).
Again, this is I how do _devel work...I code some logical set of
functionality (in this case core + onboard serial/emac), make sure it's
pretty enough that I'm not embarassed, and then I push it out.  I've
also been asked not to push until paulus is satisfied with the low-level
booke support.

In my years of contributing to Linux/PPC, this is the first time I've
had someone question how/when I contribute my work back.  I've always
pushed stuff out as soon as it makes sense.

Regards,
--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
