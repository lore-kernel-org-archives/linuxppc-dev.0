Date: Wed, 23 Jun 1999 15:17:42 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Kevin Puetz <kp11901@cedarnet.org>
cc: Justin Vallon <vallon@mindspring.com>,
        Hollis R Blanchard <hollis+@andrew.cmu.edu>,
        LinuxPPC-Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: dl-load.c (ld.so) bug??
In-Reply-To: <199906231258.HAA25989@www.cedarnet.org>
Message-ID: <Pine.LNX.4.10.9906231517130.23991-100000@mercator.cs.kuleuven.ac.be>
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

I don't think so:

| callisto$ dpkg -s electric-fence
| Package: electric-fence
| Status: install ok installed
| Priority: standard
| Section: devel
| Installed-Size: 48
| Maintainer: Debian QA Group <debian-qa@lists.debian.org>
| Version: 2.1-1
| Depends: libc6 (>= 2.1)
           ^^^^^^^^^^^^^^
| Description: A malloc(3) debugger
|  Use virtual memory hardware to detect illegal memory accesses.

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
