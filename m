Message-ID: <3BA62583.55E48A97@mvista.com>
Date: Mon, 17 Sep 2001 12:32:03 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Erratum 51 bugfix?
References: <20010917152316.O3851@zax>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:
>
> According to the ppc405gp errata, the workaround for erratum 51 is
> incorrect.

Got it, thanks.  I actually went to read the 4xx errata this time instead
of just blindly accepting the patch as I did last time.  There are some
other nasty things we should consider fixing.  The worst is #67, and now
they have told us about #77 so we can fix up the ATOMIC_SYNC_FIX....

Of all the errata, #77 is the only one we have seen with Linux.  I guess
you could force #51 to occur, but whether you call ITLBmiss or DTLBmiss
probably doesn't matter because they end up at the same place.  We are
somewhat lucky with #67 because I don't think we have mapping situations
where this can occur.  Although, some days I read it and think otherwise.....


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
