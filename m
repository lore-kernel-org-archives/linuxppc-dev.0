Message-ID: <3A30F1D2.16C3EA2A@wtal.de>
Date: Fri, 08 Dec 2000 15:36:02 +0100
From: Christof Petig <christof.petig@wtal.de>
MIME-Version: 1.0
To: "Halfmann, Klaus" <khalfmann@libra.de>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: AW: Sound on an iBook?
References: <F14441D40E5AD3118886005004607AD10BDE8C@MAIL1>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Halfmann, Klaus" wrote:

> Christof Petig <mailto:christof.petig@wtal.de> wrote:
> >
> > Hello,
> >
> > I got no answer on the debian-ppc list, so I'll try here.
> >
> > does anybody know a way to get the sound hardware on my iBook working?
> > Everything else is working fine.
> >
>
> The iBook has a different Hardware than all other Macs found so far.

Yes, this validates my suspicions.

> There is an (unsupported, ugly ...) version of dmasound that
> sometimes works on iBooks, but it provides no control of the
> output,

read: no volume control, no frequency change? That is not nice but
acceptable.

> it just takes what OF or MacOS left behind. So using
> such a Kernel/Module is a kind of russian roulette because it
> will block forever when intializing fails.

I would love/dare to try it.

> This issue needs a good assembler-/Forth- Programmer that must
> use MacsBug in MacOS or dissassemble the OF to find out whats
> going on there.

Oh no, that sounds really bad. No specs available, no darwin driver?

> I'd really like to do that but that is nothing
> I can do when going to work by train ....

Hmm. It reads like a joke. But I love to work on my computer in a train.

I would offer some time but I don't know any PPC assembly. C and
Linux-kernel are no strangers to me.

Christof


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
