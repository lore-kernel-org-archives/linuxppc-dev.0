Message-ID: <20000511170628.22841.qmail@web1705.mail.yahoo.com>
Date: Thu, 11 May 2000 10:06:28 -0700 (PDT)
From: Gabriel Ricard <g_ricard@yahoo.com>
Subject: Re: Lombard hard freeze (update: mem>64MB)
To: Bernhard Reiter <bernhard@intevation.de>, linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Well, if we're gonna do some controlled tests we
should all probably start out with the same kernel to
begin with. Which one is the latest greatest stable
version? I suppose we should all test with the exact
same kernel config, so if someone wants to put their
kernel, system.map, and modules up on an ftp site so
we can all start with that kernel, I could start
testing diff. configs on my PB immerdiately. :)


--- Bernhard Reiter <bernhard@intevation.de> wrote:
> On Thu, May 11, 2000 at 11:07:39AM +0200, Michael
> Schmitz wrote:
> > > > i've done some reasonably big compiles and run
> seti@home at the same time.
> > > > however i've never kept at it for excessive
> periods of time...i'll leave a
> > > > kernel make looping tonight building off an
> nfs disk to the local disk
> > > > and see if anything turns up by morning...
> > >
> > > I have left my lombard running for 4 days in a
> row which included several
> > > sleeps. During this period I did a 6 hour stint
> playing with the development
> > > kernel code and did about 20 makes. No problems
> and this was after
> > > I bumped it
> > > up to 192. I could try building GRASS just to
> empirical though.
> >
> > Seems there's more people successfully running
> >64M in their Lombard here
> > than it first seemed. Someone pointed to the
> kernel problem corner, so
> > what kernel versions were these success stories
> run on?
>
> Yes, we have to gather more data. Than then we have
> to seperate
> the problems and search for similiarties and
> differences in the
> machines.
>
> There seems to be a significant number of people
> having this hard freeze
> problem with Lombards. Here is my preliminary list,
> if I counted
> correctly:
>
> 	Hard Freezes occuring:
>
> Tim Wojtulewicz		Pismo 	128 MB
> Bernhard Reiter		Lombard 128,192   2.2.14,
> 2.2.15pre19
> Gabriel Ricard	    	Lombard 192 MB   + other
> problems
> Mario Scarpa	        hard freeze as described?  64
> MB + other problems
>
>
> 	Running fine:
>
> jeramy b smith		lombard	192 MB
> chris mccraw		lombard 128 MB 		2.2.12 thru
> 2.2.15pre20
>
>
>
> As I have no idea on how to compare the stress
> tests, I can only say
> that in 95% of all my test cases I can trigger a
> hard freeze within three
> runs of:
> 	rpm -ba gnomehack.spec
> (You can get my src.rpm from:
> ftp://intevation.de/users/bernhard/)
>
> There was one day, when I could run it five times
> but still a hard
> freeze later.
>
>
> So we should gather more data on how to recreate the
> bug and then
> ask more people to try to trigger it. As you can see
> from my preliminary
> tests, there is no obvious pattern. Maybe we should
> also check the
> different lombard models, if there are any. (At
> least I have a german
> keyboard, e.g.)
>
>
> Oh and more details from my part:
> My RAM test from MacOS was completed fine, reporting
> no errors.
> Adding the mem=64M option to the bootup (I am using
> bootx, could that
> make a difference too?) seems to make the system
> more stable so far.
>
> Jeramy, Chris: can you tell us which kernel and
> bootprocess you are using?
> 	Are you sure that linux uses all the memory?
> 	Can you build gnomehack three times?
>
>
> 	Bernhard
> --
> Professional Service around Free Software
>     (intevation.net)
> The FreeGIS Project				            (freegis.org)
> Association for a Free Informational Infrastructure
>           (ffii.org)
>

> ATTACHMENT part 2 application/pgp-signature



=====
Gabriel Ricard
g_ricard@yahoo.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
