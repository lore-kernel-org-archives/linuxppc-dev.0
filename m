From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15389.3566.531070.447917@argo.ozlabs.ibm.com>
Date: Mon, 17 Dec 2001 08:11:10 +1100 (EST)
To: Andrew Cagney <ac131313@cygnus.com>
Cc: Kumar Gala <kumar.gala@motorola.com>,
	linuxppc-dev@lists.linuxppc.org, Daniel Jacobowitz <drow@mvista.com>,
	Kevin Buettner <kevinb@redhat.com>, gdb@sources.redhat.com,
	ezannoni@cygnus.com, fsirl@kernel.crashing.org
Subject: Re: AltiVec register ptrace support
In-Reply-To: <3C1AB0A5.7040102@cygnus.com>
References: <Pine.GSO.4.40.0112141249070.21737-100000@softail.somerset.sps.mot.com>
	<3C1AB0A5.7040102@cygnus.com>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Andrew Cagney writes:

> The Linux/PPC kernel supports PEEK/POKE for fetching registers.  The
> proposed Kernel interface _consistently_ extends that interface using
> the exact same mechanims to obtain the altivec regiters.  All the
> required changes for this have been posted and have been demonstrated to
> work.
>
> Separate to that, it has been _proposed_ that the PPC ptrace() interface
> be changed so that get/set reg for all register classes be added
> (incomplete patch posted).  Isn't this separate to the problem at hand?

If we are going to add a get/set reg interface for the altivec vector
registers, I would rather not extend the peek/poke interface to do
that as well.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
