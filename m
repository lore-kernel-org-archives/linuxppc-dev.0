Message-ID: <392AA6CF.69A69F4C@relog.ch>
Date: Tue, 23 May 2000 17:42:07 +0200
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: daenzerm@student.ethz.ch
MIME-Version: 1.0
To: Francois Felix Ingrand <felix@ingrand.net>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: memory pb on Pismo... rumors or reality...
References: <x8qbt1x70gt.fsf@alf.laas.fr>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Francois Felix Ingrand wrote:

> I plan to add some mem to my pismo (64->192)... should I fear Linux crashs?

I've experienced a hard lockup on Sunday running a self-compiled 2.2.15
(rsync'd on Sunday from pmac-stable) on my 400 Mhz Pismo with 64 MB RAM. The
machine was up for about 12 hours and it happened during high CPU, disk and
network activity (I was downloading several 100 MB from another machine on the
LAN while building a kernel).


Looks like you can add me to the club :-/


Michel


--
...and that is how we know the Earth to be banana-shaped.
______________________________________________________________________________
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
