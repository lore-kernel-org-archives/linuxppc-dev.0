Message-ID: <388C1704.5F4E270C@Ferrari.DE>
Date: Mon, 24 Jan 2000 10:10:28 +0100
From: Rolf Fiedler <Rolf.Fiedler@Ferrari.DE>
Reply-To: Rolf.Fiedler@Ferrari.DE
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: debugging a PPC405GP target
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

currently we are looking for a solution to debug gcc generated code
on the PPC405GP target. All debuggers I have found so far are hosted
on Win9x/NT. This is sub-optimal, since our tool-chain is hosted on
linux.

I know that I can use gdb with a gdb-server running on the target,
however I prefer access to the JTAG debug port of the PPC405GP.
The Macraigor Wiggler devices support JTAG debugging for PPC405
in the same way as for Motorola MPC8xx devices. There is a gdb
target for MPC8xx and Wigglers. What I would like to do is adapt
the source for the MPC8xx target to PPC405. My problem is that
I have no documentation about the PPC405 JTAG debug port (and couldn't
find it on ibm's web site either)
Is there anybody out there that knows of:
a) documentation for the debug port of the PPC405GP?
b) a different solution to the problem?
c) knows of somebody who has already done this?
any help is higly appreciated
kind regards,
rolf

--
+-----------------+-------------------------------------------------+
|    _____        |  Rolf Fiedler    (Electronic Design Engineer)   |
|   / ___/        |  Ferrari electronic AG                          |
|  / _/           |  phone: +49 3328 4559 0   fax: +49 3328 4559 60 |
| /_/e/r/r/a/r/i/ |  <http://www.Ferrari.DE>                        |
|  electronic AG  |  <mailto:Rolf.Fiedler@Ferrari.DE>               |
+-----------------+-------------------------------------------------+

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
