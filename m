Date: Sat, 27 Apr 2002 22:07:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: oops in arch/ppc/kernel/ocp.c
Message-ID: <20020427120747.GN1475@zax>
References: <Pine.LNX.4.30.0204261416440.16519-100000@hill.cs.ucr.edu> <3CC9CF85.2030506@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CC9CF85.2030506@pacbell.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Apr 26, 2002 at 03:07:01PM -0700, Armin wrote:
>
> John Tyner wrote:
> >Our 405's are oops'ing in arch/ppc/kernel/ocp.c:
> >
> >max is unitialized if EMAC_NUMS is defined to be less than or equal to 1.
> >
> >ocp_register is returning 2 when it should be registering eth0 (and
> >returning 0).
>
> Thats been fixed and been sent in

Don't be too sure we're out of the woods yet.  I'm tracking down a bug
triggered by those changes which seems to be the result of a compiler
bug.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
