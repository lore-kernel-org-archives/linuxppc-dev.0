Message-ID: <396DB817.4C2D82F1@relog.ch>
Date: Thu, 13 Jul 2000 14:37:43 +0200
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: daenzerm@student.ethz.ch
MIME-Version: 1.0
To: Taylor Holliday <wtholliday@ucdavis.edu>
CC: Linux PPC Developer List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Xfree 4.0.1 dual head attempt
References: <396D1C7B.AA6864F5@ucdavis.edu>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Taylor Holliday wrote:

> Attached is the latest XFree86.0.log as well as the XF86Config from my
> recent build (yesterday) of 4.0.1 with the drivers rsync'ed from
> penguinppc.org. Hey, at least it doesn't crash the machine (AGP G4, 2
> r128) :-). Any suggestions on what to do or where to start debugging?

A gdb backtrace mey be interesting, at least with a static server.


> (==) ServerLayout "DualHead"
> (**) |-->Screen "Screen0" (0)
> (**) |   |-->Monitor "Monitor0"
> (**) |   |-->Device "r128"
> (**) |-->Screen "Screen1" (1)
> (**) |   |-->Monitor "Monitor0"
> (**) |   |-->Device "r128.1"

You are using the same Monitor for both Screens. Have you tried using
different ones? (All in terms of XF86Config ;)


Michel


--
Pauli's exclusive, Heisenberg's uncertain, and Schroedinger just waves.
______________________________________________________________________________
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
