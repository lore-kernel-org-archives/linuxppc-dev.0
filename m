Date: Thu, 10 Jan 2002 12:58:48 -0600 (CST)
From: Kumar Gala <kumar.gala@motorola.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Andrew Cagney <ac131313@cygnus.com>,
	Kumar Gala <Kumar.Gala@motorola.com>,
	<linuxppc-dev@lists.linuxppc.org>,
	Daniel Jacobowitz <drow@mvista.com>,
	Kevin Buettner <kevinb@redhat.com>, <gdb@sources.redhat.com>,
	<ezannoni@cygnus.com>, <fsirl@kernel.crashing.org>
Subject: Re: AltiVec register ptrace support
In-Reply-To: <15389.3566.531070.447917@argo.ozlabs.ibm.com>
Message-ID: <Pine.GSO.4.40.0201101254250.25917-100000@softail.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul,

Can you please make a decision regarding which version (or both) of the
AltiVec ptrace support should go into the kernel.

The two patches are available here:

http://lists.linuxppc.org/linuxppc-dev/200112/msg00107.html

The change is holding up altivec support for gdb.

Thanks

- kumar

On Mon, 17 Dec 2001, Paul Mackerras wrote:

> Andrew Cagney writes:
>
> > The Linux/PPC kernel supports PEEK/POKE for fetching registers.  The
> > proposed Kernel interface _consistently_ extends that interface using
> > the exact same mechanims to obtain the altivec regiters.  All the
> > required changes for this have been posted and have been demonstrated to
> > work.
> >
> > Separate to that, it has been _proposed_ that the PPC ptrace() interface
> > be changed so that get/set reg for all register classes be added
> > (incomplete patch posted).  Isn't this separate to the problem at hand?
>
> If we are going to add a get/set reg interface for the altivec vector
> registers, I would rather not extend the peek/poke interface to do
> that as well.
>
> Paul.
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
