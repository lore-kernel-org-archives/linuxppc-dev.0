Message-ID: <392BBEE3.B0091F67@relog.ch>
Date: Wed, 24 May 2000 13:37:07 +0200
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: daenzerm@student.ethz.ch
MIME-Version: 1.0
To: Francois Felix Ingrand <felix@ingrand.net>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: memory pb on Pismo... rumors or reality...
References: <x8qbt1x70gt.fsf@alf.laas.fr> <392AA6CF.69A69F4C@relog.ch> <x8qd7mcmo95.fsf@alf.laas.fr>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Francois Felix Ingrand wrote:

> > > I plan to add some mem to my pismo (64->192)... should I fear Linux
> > > crashs?
> >
> > I've experienced a hard lockup on Sunday running a self-compiled 2.2.15
> > (rsync'd on Sunday from pmac-stable) on my 400 Mhz Pismo with 64 MB RAM.
> > The
>
> But this is not related to the memory pb... as you have 64 meg only. My
> question was more about the risk of "numerous" chrashes on a machine with 2
> memory banks. (as this was reported here a while ago).

AFAIR the cause for the lockups hasn't been determined yet, and I'm a counter
example for the theory that it's caused by certain memory configurations.


Michel


--
I believe the technical term is "Oops!"
______________________________________________________________________________
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
