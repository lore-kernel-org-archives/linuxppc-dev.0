Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.4.19 on dual 1gig G4 funny slow down to kernel death experience
Date: Sat, 8 Feb 2003 08:50:54 -0500
Cc: linuxppc-dev@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
References: <200302071629.28657.kevin.hendricks@sympatico.ca> <1044710873.9705.106.camel@zion.wanadoo.fr>
In-Reply-To: <1044710873.9705.106.camel@zion.wanadoo.fr>
MIME-Version: 1.0
Message-Id: <200302080850.54439.kevin.hendricks@sympatico.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Ben,

I don't even remember anymore.  :-)

But the of device tree under the cpu has this cpu-version info:

8001 0201

Which from cputables.c looks like a 7455

Also, this is a very rare event (it has only happned twice in 6 months or
so).  The only thing in common with both events is that I have several
very large compiles going on in multiple processes at the same time (I
have two different xterms running independent compiles of OpenOffice.org),
while also surfing and things (killing time while the compiles continue)

I know this is not a lot to go on but it is now repeatable.

Thanks,

Kevin

On February 8, 2003 08:27, Benjamin Herrenschmidt wrote:
> On Fri, 2003-02-07 at 22:29, Kevin B. Hendricks wrote:
> > I just experienced the funny slow down until kernel death experience
> > again that I reported many months ago on my dual 1gig G4 machine (smp
> > with 768 meg of memory)
> >
> > The dmesg log is full of a long stream of the following
> >
> > wait_on_irq, CPU 0:
> > irq:  -1 [0 0]
> > bh:   0 [0 0]
>
> Argh !
>
> The global irq count should never _ever_ get to -1, that's very bad...
>
> Either some weird codepath I haven't manage to figure out, or,
> and that's what I'm afraid of, for some reasons, atomic operations
> between CPUs failed, which should obviously never happen !
>
> Remind me which rev of the CPU it is ?
>
> Ben.
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
