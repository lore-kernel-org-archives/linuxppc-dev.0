From: "barry.fisher" <barry.fisher@seranoa.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: kgdb support for 8260
Date: Wed, 3 Apr 2002 10:39:01 -0500
Message-ID: <000a01c1db25$add3db20$7d0110ac@Seranoa.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello All:
Thanks to everyone so far for their help in answering my questions with
regards to my questions regarding kgdb support for the 8260.

We tried to build kgdb into the kernel and got some undefined symbols
like kgdb_interruptible, putDebugChar, getDebugChar, set_scc_map to name
a few. We would like to debug remotely via a network connection. Any
thoughts why we are getting these undefines. We looked in the uart.c(as
was suggested) file and our version of asm-ppc/8260_io/uart.c does not
have these functions. Is there something special that needs to be done
in the kernel build? Or do we need to apply a patch to the kernel?

More importantly, does anyone know if remote kdgb debugging on the 8260
is supported.

Again I am a bit new at this and your patience and help is greatly
appreciated. Thanks again!

Barry O. Fisher
Seranoa Networks
barry.fisher@seranoa.com
978-897-3434 x272


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
