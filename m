Message-ID: <3C1AB0A5.7040102@cygnus.com>
Date: Fri, 14 Dec 2001 21:08:37 -0500
From: Andrew Cagney <ac131313@cygnus.com>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@motorola.com>
Cc: linuxppc-dev@lists.linuxppc.org,
	Daniel Jacobowitz <drow@mvista.com>,
	Kevin Buettner <kevinb@redhat.com>, gdb@sources.redhat.com,
	ezannoni@cygnus.com, fsirl@kernel.crashing.org, paulus@samba.org
Subject: Re: AltiVec register ptrace support
References: <Pine.GSO.4.40.0112141249070.21737-100000@softail.somerset.sps.mot.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Is there any reason that we can not spport both methods.  There are
> applications in which having the ability to get all the registers is a
> single syscall is a major performance improvement.

2/c worth.

Yes.

The Linux/PPC kernel supports PEEK/POKE for fetching registers.  The
proposed Kernel interface _consistently_ extends that interface using
the exact same mechanims to obtain the altivec regiters.  All the
required changes for this have been posted and have been demonstrated to
work.

Separate to that, it has been _proposed_ that the PPC ptrace() interface
be changed so that get/set reg for all register classes be added
(incomplete patch posted).  Isn't this separate to the problem at hand?

enjoy,
Andrew


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
