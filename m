Date: Thu, 4 Oct 2001 14:49:37 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: ppc_md.ppc_kbd_sysrq_xlate
Message-ID: <20011004144937.F32269@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hey all.  Can anyone think of a good reason to have this field enclosed
in #ifdef/#endif in include/asm-ppc/machdep.h?  This and SMP are the
only things which get done like this, and I can't really think of a good
reason why this is done.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
