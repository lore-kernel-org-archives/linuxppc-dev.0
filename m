Message-Id: <v04003a01b32f4ee29cfd@[205.161.35.44]>
In-Reply-To: <Pine.HPP.3.96.990405103702.1043M-100000@gra-ux1.iram.es>
References: <8x677fp6hn.fsf@s52.informatik.uni-bremen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 6 Apr 1999 00:53:56 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Douglas Godfrey <dvdoug@tiac.net>
Subject: Re: Apple Job Posting and Good News for LinuxPPC developers
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Reoly to Gabriel Paubert, 4/5/99 6:06 PM +0200: Re: Apple Job Posting and
Good News for LinuxPPC devel

>
>No, I want to saturate L2 BW, which is going to be in the 10 Gb/s range
>soon (500 Mhz @ 128 bit is 8Gb/s, double for 256 bit). With L2 caches
>larger than 1 Mb, my apps basically do not thrash L2 cache (and are even
>careful enough not to cause too many writebacks to it which could halve
>effective BW), provided it has enough associativity (4 way at least).
>
With IBM recent announcement of Imbedded DRAM Macros for their Blue Logic
library, the previous limits on L2 cache bandwidth no longer apply. IBM
can deliver a G3 or G4 CPU with 2meg of imbedded DRAM as L2 with a 1024
bit wide L2 cache bus. This would allow a 4 way set associative cache with
4 simultaneous L2 cache transfers for read or write with a 2.5ns DRAM speed.
The CPU die size would be only 50% larger and would only need 5 more mask
steps. The cost of such a G3 or G4 CPU should be only 30% to 50% higher
than current generation G3 CPUs, about the same as current Intel Pentium III
CPUs. Combine this with the cache controller from the Power 3 CPU and IBM
will be able to achieve between 8Gb/sec and 32Gb/sec L2 cache bandwidth.
A 550mhz PPC G3 probably cannot even approach using that much bandwidth.

Thanx...
  Doug



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
