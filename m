Date: Wed, 23 Jun 1999 10:19:32 -0400 (EDT)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: Kevin Puetz <kp11901@cedarnet.org>
cc: Justin Vallon <vallon@mindspring.com>,
        LinuxPPC-Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: dl-load.c (ld.so) bug??
In-Reply-To: <199906231258.HAA25989@www.cedarnet.org>
Message-ID: <Pine.LNX.3.96L.990623101810.1657A-100000@unix47.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 23 Jun 1999, Kevin Puetz wrote:

> Umm... just thought of this - a segfault in __libc_start_main is the symptom
> of an old R4 binary on a glibc2.1 system... did ElectricFence not get
> updated (just a thought)? Then - if both libraries load - it segfaults when
> electricfence initializes _it's_ glibc dynamic link. One could try
> rebuilding the SRPM and see...
> 
> Possible? Or am I on crack (don't know much about efence or glibc internals,
> so... probably the latter.)

Doesn't look like it's an R4 problem... I just rebuilt it and it does the same
thing. A different __libc_start_main thing, I guess.

-Hollis


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
