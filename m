Message-ID: <20000511171009.23577.qmail@web1705.mail.yahoo.com>
Date: Thu, 11 May 2000 10:10:09 -0700 (PDT)
From: Gabriel Ricard <g_ricard@yahoo.com>
Subject: Re: Lombard hard freeze (update: mem>64MB)
To: Seanano <sto9013@ksu.edu>, Bernhard Reiter <bernhard@intevation.de>
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm using yaboot too. Does your kernel intialize the
video correctly when you first boot the machine up
from a cold state (as in, it was shutdown, not a
reboot)? I have to go into OF from a cold state, and
boot my macos partition just to the point where the
ROM initializes the video with a grey screen,
otherwise, I get this odd lockup when I boot into
Linux. As the kernel messages scroll down the screen
its fine until it has to scroll the screen up, it just
locks up when it does that. What kernel, yaboot, and
LinuxPPC (or other distro) version are you using?


--- Seanano <sto9013@ksu.edu> wrote:
>
>   I've been running a lombard with 192 megs of RAM
> since it was purchased
> without any problem.  I've been running kernels
> 2.2.14 - 2.2.15-pre20
> with almost all of the 2.2.15-preXX kernels coming
> from the rysnc server
> at linuxcare.com.au.  Up until I installed the 9.0.4
> upgrade a few weeks
> ago I was using bootX, now I've switched over to
> yaboot.  I usually
> compile multiple programs at a time and I've never
> seen any kernel errors
> or freezes.  When the kernel boots it shows Total
> Memory = 192MB.
>
>
> [seanano@ip35 seanano]$ cat /proc/cpuinfo
> processor       : 0
> cpu             : 750
> temperature     : 0 C
> clock           : 399MHz
> revision        : 130.2
> bogomips        : 801.18
> zero pages      : total 0 (0Kb) current: 0 (0Kb)
> hits: 0/261 (0%)
> machine         : PowerBook1,1
> motherboard     : PowerBook1,1 MacRISC Power
> Macintosh
> L2 cache        : 1024K unified
> memory          : 192MB
> pmac-generation : NewWorld
>
>
> [seanano@ip35 /proc]$ cat /proc/meminfo
>         total:    used:    free:  shared: buffers:
> cached:
> Mem:  195981312 50966528 145014784 25296896  3297280
> 22179840
> Swap: 268427264        0 268427264
> MemTotal:    191388 kB
> MemFree:     141616 kB
> MemShared:    24704 kB
> Buffers:       3220 kB
> Cached:       21660 kB
> SwapTotal:   262136 kB
> SwapFree:    262136 kB
>
>
>   I'd be happy to run some tests if needed.  My
> network access on the
> lombard is a bit unstable right now so I couldn't
> download the gnomehack
> source...  I should be back to normal in a few days.
>  I don't even have
> gnome installed anyway...
>
>
> Sean
>
>
> On Thu, 11 May 2000, Bernhard Reiter wrote:
>
> > On Thu, May 11, 2000 at 11:07:39AM +0200, Michael
> Schmitz wrote:
> > > > > i've done some reasonably big compiles and
> run seti@home at the same time.
> > > > > however i've never kept at it for excessive
> periods of time...i'll leave a
> > > > > kernel make looping tonight building off an
> nfs disk to the local disk
> > > > > and see if anything turns up by morning...
> > > >
> > > > I have left my lombard running for 4 days in a
> row which included several
> > > > sleeps. During this period I did a 6 hour
> stint playing with the development
> > > > kernel code and did about 20 makes. No
> problems and this was after
> > > > I bumped it
> > > > up to 192. I could try building GRASS just to
> empirical though.
> > >
> > > Seems there's more people successfully running
> >64M in their Lombard here
> > > than it first seemed. Someone pointed to the
> kernel problem corner, so
> > > what kernel versions were these success stories
> run on?
> >
> > Yes, we have to gather more data. Than then we
> have to seperate
> > the problems and search for similiarties and
> differences in the
> > machines.
> >
> > There seems to be a significant number of people
> having this hard freeze
> > problem with Lombards. Here is my preliminary
> list, if I counted
> > correctly:
> >
> > 	Hard Freezes occuring:
> >
> > Tim Wojtulewicz		Pismo 	128 MB
> > Bernhard Reiter		Lombard 128,192   2.2.14,
> 2.2.15pre19
> > Gabriel Ricard	    	Lombard 192 MB   + other
> problems
> > Mario Scarpa	        hard freeze as described?  64
> MB + other problems
> >
> >
> > 	Running fine:
> >
> > jeramy b smith		lombard	192 MB
> > chris mccraw		lombard 128 MB 		2.2.12 thru
> 2.2.15pre20
> >
> >
> >
> > As I have no idea on how to compare the stress
> tests, I can only say
> > that in 95% of all my test cases I can trigger a
> hard freeze within three
> > runs of:
> > 	rpm -ba gnomehack.spec
> > (You can get my src.rpm from:
> ftp://intevation.de/users/bernhard/)
> >
> > There was one day, when I could run it five times
> but still a hard
> > freeze later.
> >
> >
> > So we should gather more data on how to recreate
> the bug and then
> > ask more people to try to trigger it. As you can
> see from my preliminary
> > tests, there is no obvious pattern. Maybe we
> should also check the
> > different lombard models, if there are any. (At
> least I have a german
> > keyboard, e.g.)
> >
> >
> > Oh and more details from my part:
> > My RAM test from MacOS was completed fine,
> reporting no errors.
> > Adding the mem=64M option to the bootup (I am
> using bootx, could that
> > make a difference too?) seems to make the system
> more stable so far.
> >
> > Jeramy, Chris: can you tell us which kernel and
> bootprocess you are using?
> > 	Are you sure that linux uses all the memory?
> > 	Can you build gnomehack three times?
> >
> >
> > 	Bernhard
> > --
> > Professional Service around Free Software
>       (intevation.net)
> > The FreeGIS Project				            (freegis.org)
> > Association for a Free Informational
> Infrastructure            (ffii.org)
> >
>
>
>


=====
Gabriel Ricard
g_ricard@yahoo.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
