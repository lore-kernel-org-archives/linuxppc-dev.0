To: Rolf.Fiedler@Ferrari.DE
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: debugging a PPC405GP target
References: <388C1704.5F4E270C@Ferrari.DE>
From: Jesper Skov <jskov@cygnus.co.uk>
Date: 24 Jan 2000 10:33:48 +0100
In-Reply-To: Rolf Fiedler's message of "Mon, 24 Jan 2000 10:10:28 +0100"
Message-ID: <otemb7u83n.fsf@thinktwice.zoftcorp.dk>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>>>>> "Rolf" == Rolf Fiedler <Rolf.Fiedler@Ferrari.DE> writes:

Rolf> Hi there,

Rolf> currently we are looking for a solution to debug gcc generated
Rolf> code on the PPC405GP target. All debuggers I have found so far
Rolf> are hosted on Win9x/NT. This is sub-optimal, since our
Rolf> tool-chain is hosted on linux.

Rolf> I know that I can use gdb with a gdb-server running on the
Rolf> target, however I prefer access to the JTAG debug port of the
Rolf> PPC405GP.  The Macraigor Wiggler devices support JTAG debugging

I don't think this would work (or at least not easily). When you
access the target through a wiggler it's at a very low level (on the
CPU, basically - you don't communicate with software in the
target).

For debugging an application you need to communicate with gdbserver -
ethernet is the optimal solution, if your board has
ethernet. Otherwise you have to use serial.

You may be able to make the wiggler work as a regular serial
connection, but I don't see what you gain by that over using a
standard ethernet/serial connection (except if the only interface on
the board is the wiggler one).

Jesper

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
