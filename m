Message-Id: <20000712141525.Postino-021702@smtp01.highway.ne.jp>
Date: Wed, 12 Jul 2000 14:15:25 +0900
To: linuxppc-dev@lists.linuxppc.org
From: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: today's problem kernel-2.4.0-t3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi!

Priority member has gone.

Any help

Kaoru

timer.c: In function `update_process_times':
timer.c:580: structure has no member named `priority'
timer.c:580: `DEF_PRIORITY' undeclared (first use in this function)
timer.c:580: (Each undeclared identifier is reported only once
timer.c:580: for each function it appears in.)
make[2]: *** [timer.o] Error 1
make[2]: Leaving directory `/usr/src/redhat/BUILD/linux/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/redhat/BUILD/linux/kernel'
make: *** [_dir_kernel] Error 2
Bad exit status from /var/tmp/rpm-tmp.11753 (%build)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
