Date: Fri, 11 May 2001 17:36:20 -0600
From: Val Henson <val@nmt.edu>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: Ken Offer <koffer@arlut.utexas.edu>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Problem with linuxppc smp.c
Message-ID: <20010511173620.K18959@boardwalk>
References: <3AF8554D.BF250E0A@arlut.utexas.edu> <Pine.LNX.4.30.0105091253400.17484-100000@opal.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.30.0105091253400.17484-100000@opal.biophys.uni-duesseldorf.de>; from schmitz@opal.biophys.uni-duesseldorf.de on Wed, May 09, 2001 at 12:54:36PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, May 09, 2001 at 12:54:36PM +0200, Michael Schmitz wrote:
>
> > smp.c: In function `smp_gemini_kick_cpu':
> > smp.c:670: `i' undeclared (first use in this function)
> > smp.c:670: (Each undeclared identifier is reported only once
> > smp.c:670: for each function it appears in.)
> > smp.c: In function `smp_gemini_setup_cpu':
> > smp.c:679: `cpu_nr' undeclared (first use in this function)
> >
> > Any thoughts?  I guess I could try to grok the author's meaning and fix
> > this... ;-)
>
> I guess it's obvious that both of these should be declared int.

Actually, this dates back from the last big SMP reorganization (in
September 2000 or so).  The variable names weren't changed to match
the variable name passed to the (newly created) function.  Gemini
hasn't compiled SMP since then.

I've written one patch to make SMP work on the Gemini (similar to an
earlier patch by Dan Cox) but Cort asked for some rewrites.  I'm
working on it as we speak.

For the confused, I'm the official Gemini board maintainer now (taking
over from Dan Cox).

-VAL

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
