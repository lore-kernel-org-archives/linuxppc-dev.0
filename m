Date: Fri, 26 Apr 2002 14:22:33 -0700 (PDT)
From: John Tyner <jtyner@cs.ucr.edu>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: oops in arch/ppc/kernel/ocp.c
Message-ID: <Pine.LNX.4.30.0204261416440.16519-100000@hill.cs.ucr.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Our 405's are oops'ing in arch/ppc/kernel/ocp.c:

max is unitialized if EMAC_NUMS is defined to be less than or equal to 1.

ocp_register is returning 2 when it should be registering eth0 (and
returning 0).


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
