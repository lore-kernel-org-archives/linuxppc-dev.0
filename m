Message-Id: <sc84a537.012@gw_tms_syd2.pty.tms.thomson-csf.com>
Date: Tue, 05 Mar 2002 10:59:45 +1100
From: "Jeremy Rosen" <Jeremy.Rosen@au.thalesgroup.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: [PATCH] use of /proc/iomem in 8xx boards
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Here is a patch to have the memory map displayed in /proc/iomem.
it was mainly adapted from arch/ppc/i386/kernel/setup.c

I have tested it with my board ( FADS with an 860T ) but I didn't test
for other board.
This also mean that the names for the IO regions of other board were my
best guess :-)

Thx

Jeremy

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
