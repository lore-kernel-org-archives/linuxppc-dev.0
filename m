Date: Sun, 7 Jan 2001 17:30:34 -0800
From: Peter Abrahamsen <peter@abrahamsen.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.4.0prerelease ac5: RTAS proc broken
Message-ID: <20010107173034.A410@gaia.mccarty>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hullo,

It appears that arch/ppc/kernel/proc_rtas.c is broken. Specifically, there
is a reference on line 230 to ppc_rtas_errorlog_read - a function which does
int exist. Sorry if this is already known.

Cheers,

Peter
(who is not subscribed to this list)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
