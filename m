Message-ID: <3BA7980B.EEBF1F5D@mvista.com>
Date: Tue, 18 Sep 2001 14:52:59 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Errata 67/77 / walnut bugs (was: Re: Erratum 51 bugfix?)
References: <20010917152316.O3851@zax> <3BA62583.55E48A97@mvista.com> <20010918102901.A1183@zax>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:

> I suspect #77 is the cause of the problems I'm seeing on the walnut
> now - it mostly works, but every so often a process will freeze up
> immune to signals.

Hmmm...We did tons of debugging on this one and pointed it out to
IBM a while back.  The ATOMIC_SYNC_FIX configuration option was the
solution to cure it.  As you can tell, it tries to address the
pipeline issues surrounding the stwcx.  I kind of hope it is the
problem, and a better silicon bug fix will solve it.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
