Date: Thu, 30 Aug 2001 16:18:12 -0400
From: Kent Borg <kentborg@borg.org>
To: linuxppc-embedded@lists.linuxppc.org
Cc: pbarada@wm.sps.mot.com, dan@mvista.com
Subject: 405 Walnut Status?
Message-ID: <20010830161812.A4855@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


What kind of shape is the 405 Walnut code in ppc.bitkeeper.com:5000
linuxppc_2_4_devel kernel?

I can't figure out how to even config and compile it.  I tried the
walnut_config and head_4xx.S dies of an unrecognized opcode (as did an
earlier attempt at a config).  Looking further, things seem missing
(for example in walnut_setup.c, arch/ppc/mm/Makefile,
asm-ppc/processor.h).

Did I start with the wrong kernel?


Thanks,

-kb, the Kent who will be off e-mail most of next week.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
