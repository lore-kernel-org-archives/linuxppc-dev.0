Message-ID: <3BB27710.68CBE18A@mvista.com>
Date: Wed, 26 Sep 2001 20:47:12 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Matt Porter <mporter@mvista.com>
Cc: "Prasad, Siva" <Siva.Prasad@smartm.com>,
	"'Tom Rini'" <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: mtmsr...
References: <35C119252057D511BB9F0003476BF8A208E5C4@freexc01.smartm.com> <20010926125756.A28204@cx258813-a.chnd1.az.home.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matt Porter wrote:

> Force's PowerBoot doesn't properly clean up caches before handing
> control over to an external program.  You are probably having
> cache problems that we have run into on some COTS Force boards.
> I had to disable, flush, reenable L1 icache on the 680/G4, for
> example.

So, you are really running on luck then.  When you disable the
cache, you are just fortunate that the necessary instructions
to do the remainder of the work just happen to be in main memory,
and that the cache was somehow implicitly invalidated so the ones
you need to get to this point aren't stale in the cache.  Are
you really sure the caches aren't cleaned up properly and this
sequence of operations isn't masking some other problem?


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
