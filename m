Date: Sat, 15 Dec 2001 11:44:43 -0600 (CST)
From: Kumar Gala <kumar.gala@motorola.com>
To: Andrew Cagney <ac131313@cygnus.com>
Cc: Kumar Gala <Kumar.Gala@motorola.com>,
	<linuxppc-dev@lists.linuxppc.org>,
	Daniel Jacobowitz <drow@mvista.com>,
	Kevin Buettner <kevinb@redhat.com>, <gdb@sources.redhat.com>,
	<ezannoni@cygnus.com>, <fsirl@kernel.crashing.org>,
	<paulus@samba.org>
Subject: Re: AltiVec register ptrace support
In-Reply-To: <3C1AB0A5.7040102@cygnus.com>
Message-ID: <Pine.GSO.4.40.0112151141570.15248-100000@softail.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> The Linux/PPC kernel supports PEEK/POKE for fetching registers.  The
> proposed Kernel interface _consistently_ extends that interface using
> the exact same mechanims to obtain the altivec regiters.  All the
> required changes for this have been posted and have been demonstrated to
> work.
>
> Separate to that, it has been _proposed_ that the PPC ptrace() interface
> be changed so that get/set reg for all register classes be added
> (incomplete patch posted).  Isn't this separate to the problem at hand?

I think you are correct they are separate issues.  I posted both methods
so we could decide in which direction we wanted to go with the ptrace
interface.  I would like to see the single word at a time interface that
currectly exists be patched to support AltiVec so we can get debugger
support working.  I would like this done to the 2.4.x tree.

- kumar


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
