Message-ID: <3CC40B91.90601@allot.com>
Date: Mon, 22 Apr 2002 16:09:37 +0300
From: Felix Radensky <felix@allot.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Cross compiling gdb-5.1.1 for ppc405
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I've managed to cross-compile gdb-5.1.1 for 405GP using
Monta Vista HHL 2.0 toolchain.  Gdb runs, I can load the executable
and set breakpoints. However, when i try to run the  program from gdb,
I get the following message:

Starting program: /tmp/hello
Don't know how to run.  Try "help target".

The same program runs fine  in gdb-5.0 from Monta Vista
HHL 2.0.

Any ideas ?

Thanks a lot.

Felix.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
