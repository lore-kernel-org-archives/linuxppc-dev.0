To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
Cc: "Timothy A. Seufert" <tas@mindspring.com>, ian geiser <geiseri@msoe.edu>,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>,
        LinuxPPC List <linuxppc-user@lists.linuxppc.org>
Subject: Re: G3 Upgrade Questions....
References: <Pine.LNX.4.10.9907291349260.10509-100000@mercator.cs.kuleuven.ac.be>
Content-Type: text/plain; charset=US-ASCII
From: Stefan Berndtsson <stefan@nocrew.org>
Date: 29 Jul 1999 14:12:30 +0200
In-Reply-To: Geert Uytterhoeven's message of "Thu, 29 Jul 1999 13:50:03 +0200 (CEST)"
Message-ID: <873dy77iz5.fsf@hades.nocrew.net>
MIME-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be> writes:

> On 29 Jul 1999, Stefan Berndtsson wrote:
> > "Timothy A. Seufert" <tas@mindspring.com> writes:
> > > As a general rule the 750 scores about 2 bogomips per MHz, so this is
> > > suspicious too.
> > 
> > On my Lombard/333 I get:
> > 
> > # cat /proc/cpuinfo
> > processor       : 0
> > cpu             : 750
> > temperature     : 0 C
> > clock           : 333MHz
> > revision        : 130.2
> > bogomips        : 333.41
> > zero pages      : total 0 (0Kb) current: 0 (0Kb) hits: 0/256 (0%)
> > machine         : PowerBook1,1
> > motherboard     : PowerBook1,1 MacRISC Power Macintosh
> > L2 cache        : 512K unified
> > memory          : 64MB
> > 
> > so either it's reporting things wrong for me, or 750 doesn't always score 2/MHz.
> 
> Since the 750 is derived from the 603e, it scores 1 bogomips per MHz. The 604e
> does 2 bogomips per MHz.

That's not true either.. a friends G3/300 (some stationary thing), reports 601.xx
bogomips.. unless something's screwed with _that_ setup.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
