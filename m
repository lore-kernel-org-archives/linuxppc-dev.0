Date: Tue, 30 Jan 2001 15:45:16 +0000
Subject: Re: network stack oops 2.4.1/gcc 2.95.3 
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Cc: David Edelsohn <dje@watson.ibm.com>, linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010130154506.51058DB9F1@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Franz,

You are probably right - it's likely to be a red-herring.

Mind you - an Oops is an Oops ;)

- the compiler issue may be a red-herring the oops was definitely real.

On Tue, Jan 30, 2001,  Franz Sirl wrote:
> At least it would be nice if you could tell me the version of the RPM you
> were using before. I haven't added new patches since early December and
> most of my RPM patches are in test2 (even more in test3) now.

the 'fault' was with test2 (2.92.3-t2) + glibc 2.1.3-15g

the previous version (I have been using for some considerable time) was:

2.95.2-1f + glibc 2.1.3-4a

> Another datapoint:
> [fsirl@entropy:~]$ cat /proc/version
> Linux version 2.4.0 (trini@entropy.crashing.org) (gcc version 2.95.3
> 20010111 (prerelease/franzo/20010111)) #1 Sun Jan 14 15:10:21 MST 2001
> [fsirl@entropy:~]$ uptime
>    5:21am  up 11 days, 20:50,  2 users,  load average: 0.00, 0.00, 0.00

FWIW: once it's up, mine stays there as well... but I'm rebooting a lot at
the moment because of what I'm doing.  Also I'm using bk 2.4.1.

I have a _hunch_ that it is a failure/timeout in connecting to the DNS that
triggers the effect.

> But this machine has a fairly weak net connection, so mabe this is never
> triggered (define heavy network load?).

I have a combined ethernet bridge/NAT/ISDN modem - this occurred when it was
operating at full capacity downloading binary data (i.e. quite likely to
drop packets).

> I would rather think this is a new kernel bug...

yeah, probably... I assume program error first, compiler bug second...

It was just a little unusual... I'll try and find some more hard facts
(otherwise I guess we should forget it unless someone else sees something).

I haven't had time, yet, to look if any of the network code changed around
that time.

sorry if I wasted time here..
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
