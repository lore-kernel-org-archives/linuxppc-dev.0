From: Dan Foster <dsf@frontiernet.net>
Message-Id: <199909220624.CAA42912@frontiernet.net>
Subject: Re: ssh2 and multiheaded X
In-Reply-To: <199909220616.IAA00379@piglet.cpu.lu> from Michel Lanners at "Sep 22, 99 08:16:03 am"
To: mlan@cpu.lu
Date: Wed, 22 Sep 1999 02:24:30 -0400 (EDT)
Cc: pogtal@erols.com, linuxppc-user@lists.linuxppc.org,
        linuxppc-dev@lists.linuxppc.org, dsf@frontiernet.net (Dan Foster)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hot Diggety! On a bright and sunny day, Michel Lanners was rumored to have said.
> 
> On  21 Sep, this message from Doomsday Machine echoed through cyberspace:
> > 
> > Greetings all-
> >     Has anyone successfully compiled ssh2 or gotten some version of
> > multiheaded X working?  ssh1 is pretty useless, since any machine not
> > running linuxppc is running ssh2, not ssh1.
[...snip....]

1. ssh2 daemon has a ssh v1 compatibility mode that can be enabled.

2. there is no real intrinsic difference in running ssh v2 over v1;
v2 just has tighter licensing requirements. v1 code has been pored over
line by line after that bad scare (but later turned out to be unfound)
around 1.2.25 and a break-in of a key site.

Of course, neither helps much if a site has chosen to use v2 everywhere :-)

That said, I'm not running a recent version of LinuxPPC so I can't really
tell what exactly is broken at the moment. Sorry.

-Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
