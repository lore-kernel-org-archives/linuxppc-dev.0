Message-ID: <3B8A8F26.EC447C4@mvista.com>
Date: Mon, 27 Aug 2001 14:19:18 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-commit@source.mvista.com,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: ppc_htab.c again
References: <20010827090729.B6925@cpe-24-221-152-185.az.sprintbbd.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini wrote:
>
> Hey all.  I notice paul made ppc_htab.c compile on all arches again.  I'm
> not about to undo this or anything, but I still don't agree with it.

Just look at it carefully.  In the past, on processors without HPTE
the code was almost one big no-op (due to conditional tests, etc.) but
somewhere there were a few sublte generic operations (like tlbie) that
were important to (nearly) all processors.  I often took advantage of
that.  The code would compile, no #ifdef necessary, generic functions
called, and in the end "the right thing" would happen :-).


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
