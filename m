Date: Wed, 9 May 2001 12:54:36 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Ken Offer <koffer@arlut.utexas.edu>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Problem with linuxppc smp.c
In-Reply-To: <3AF8554D.BF250E0A@arlut.utexas.edu>
Message-ID: <Pine.LNX.4.30.0105091253400.17484-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> smp.c: In function `smp_gemini_kick_cpu':
> smp.c:670: `i' undeclared (first use in this function)
> smp.c:670: (Each undeclared identifier is reported only once
> smp.c:670: for each function it appears in.)
> smp.c: In function `smp_gemini_setup_cpu':
> smp.c:679: `cpu_nr' undeclared (first use in this function)
>
> Any thoughts?  I guess I could try to grok the author's meaning and fix
> this... ;-)

I guess it's obvious that both of these should be declared int.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
