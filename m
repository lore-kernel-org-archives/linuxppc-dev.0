Date: Mon, 27 Aug 2001 09:07:29 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-commit@source.mvista.com,
	linuxppc-dev@lists.linuxppc.org
Subject: ppc_htab.c again
Message-ID: <20010827090729.B6925@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hey all.  I notice paul made ppc_htab.c compile on all arches again.  I'm
not about to undo this or anything, but I still don't agree with it.  It
does _not_ do anything when running on !6xx, more more specifically
!CPU_FTR_L2CR.  We -EFAULT on this case before we do anything.  I _think_
but I'm not totally sure that the bits which were printed out before, in the
stock code are bogus.  I also think that if we are going to put in other,
useful infos on all procs, we should put it in another file (src and /proc).
Just my 2 cents.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
