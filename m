Message-ID: <3909A05A.E1901D52@cern.ch>
Date: Fri, 28 Apr 2000 16:29:46 +0200
From: Pei-Jie Hong <Pei-Jie.Hong@cern.ch>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: A question about head.S
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In arch/ppc/kernel/head.S, there are lines looks like
bne 4f or b 5f, I know they are branch instructions, but what
about 4f or 5f. Are they the relative length? and what is the unit,
I mean if 4f is a number , is it number of instructions or number
of bytes or words?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
