Message-ID: <3BA8C207.79FFF7CD@prodys.net>
Date: Wed, 19 Sep 2001 18:04:24 +0200
From: Pedro Parrilla <pparrilla@prodys.net>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Problems with remote debugging on MBX860
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 Hello!

    I am debugging  a remote target (Hard Hat Linux on a MBX860) from my

host (Red Hat Linux 7.0 on x86 PC) with ppc_8xx_gdb(cross-dev). I got to
connect both with
'target extended-remote' directive in the host, and with gdbserver in
the target, gdb can do STEP,RUN...and the like, but I can't see the
variables values. If I try to print any local variable GDB response is
'incomplete type'. I've compiled with ppc_8xx-gcc and the 'g' option and
I've  loaded the program in GDB with file 'program'...I don't Know what
more I should do...Any bad
configuration?

 Thanks.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
