Message-ID: <3BD17DE5.9A1DAAEB@nc.rr.com>
Date: Sat, 20 Oct 2001 09:36:37 -0400
From: Ricky West <rwwest@nc.rr.com>
Reply-To: ricky.west@ericsson.com
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: xmon configuration for custom mpc860
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am trying to configure xmon to run on a custom mpc860p based board
that uses smc1 for a serial console.  My team is just begginning, this
past 2 months, to explore the use of linux for an embedded os.  We have
made alot of progress but need to understand and experience debugging
options for the kernel.  Our motto has been to start simple and add
complications as necessary.

Our intention is to use xmon for low-level target debugging.  Is this a
good idea?  Next, how do we configure the kernel.  We have turned on the
CONFIG_XMON option but are getting a vmlinux link failure.

arch/ppc/xmon/x.o: In function `xmon':
arch/ppc/xmon/x.o(.text+0x600): undefined reference to `xmon_enter'
arch/ppc/xmon/x.o(.text+0x600): relocation truncated to fit: R_PPC_REL24
xmon_en
ter
arch/ppc/xmon/x.o(.text+0x664): undefined reference to `xmon_leave'

In arch/ppc/xmon/Makefile, start.c is excluded in favor of start_8xx.c.
Where should these references come from.

We are using kernel 2.4.11 obtained from linuxppc_2_4 on 2001-10-10 with
only configuration edits needed for our custom board.  We are using MV
JE2.0 tools and a modified SELF enviornment from Wolfgang Denx.

Ricky W. West
Ericsson Inc.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
