Message-ID: <20010823212234.15232.qmail@kunk.jriver.com>
Subject: Re: 2.4.9-benh0 problems and kudos
In-Reply-To: <200108231929.VAA00718@piglet.grunz.lu> "from Michel Lanners at
 Aug 23, 2001 09:29:16 pm"
To: mlan@cpu.lu
Date: Thu, 23 Aug 2001 16:22:34 -0500 (CDT)
From: Robert E Brose II <bob@kunk.jriver.com>
Cc: linuxppc-dev@lists.linuxppc.org, olh@suse.de
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


User Michel Lanners says:
> Hooray ;-)
>
> > I've run into a couple of small problems however....
> >
> > planb.c has a problem in 2074.
> > pb->lock = 0;
>
> Yep.
>
> > pb->lock is defined as a semaphore so this gives the following
> > compiler error...
> >
> > planb.c: In function `init_planb':
> > planb.c:2074: incompatible types in assignment
>
> Just remove that line 2074. I've sent a patch off to BenH; it should
> appear in his tree RSN.
>
> Cheers
>
> Michel

Thanks! I did that on a whim earlier today and the planb driver works
great now!

Bob
--
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
