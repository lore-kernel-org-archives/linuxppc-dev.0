Date: Wed, 15 Dec 1999 09:23:00 -0700 (MST)
From: Stephen Edie <sedie@terraplex.com>
To: cort@ppc.kernel.org
cc: linuxppc-dev@lists.linuxppc.org
Subject: PCNET32 driver
Message-ID: <Pine.LNX.4.10.9912150919400.26215-100000@newhope.terraplex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Cort,

When running in 100mbit mode, the PCNET32 driver reports the following
error message:

eth0:TX FIFO error! Status 02e3

With this messages present, we have seen a number of problems from
TCP connections being closed after a few bytes of transfer to very poor
performance (1-mbit throughput) to not working at all.  Is there a quick
way to fix this problem perhaps?  We would like to get some of our
in-house CHRP machines running at the full 100mbit and we have some
customers who require 100mbit throughput as well.

Thanks,
Stephen

Terra Soft Solutions, Inc.
   Yellow Dog Linux
   "The Ultimate Companion for a Dedicated Server"
   http://www.yellowdoglinux.com/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
