Message-ID: <3F6F781F.6060706@ece.msstate.edu>
Date: Mon, 22 Sep 2003 17:30:55 -0500
From: Jan Dominik Baranski <jdb2@ece.msstate.edu>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: 2nd serial port on an Embedded Planet EP862-1.1 board
References: <03Sep3.190623adt.7317@dragon.appliedmicro.ns.ca> <1062628817.28809.12.camel@trouble> <3F56BB60.4010602@ece.msstate.edu> <1062713293.31909.14.camel@trouble>
In-Reply-To: <1062713293.31909.14.camel@trouble>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,
I'm attempting to get the second serial port working on an EP862-1.1
board. I see that I need to be concerned with BCSR4 and that the port
can be controlled via SCC1, 2, or 3.
I assume that 'struct serial_state rs_table[]' in arch/ppc/8xx_io/uart.c
needs to be set up correctly, although I'm not quite sure how to go
about doing this.
I know that this board has more BCSR registers than the CLLF, but
everything seems to be correct in arch/ppc/platforms/rpxclassic.h. I
don't have to mess with any memory mappings in arch/ppc/mm/init.c, do I?

Any pointers in the right direction?

Thanks!

-Jan Baranski


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
