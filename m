Message-ID: <17B78BDF120BD411B70100500422FC63079F8D@IIS000>
From: Patrick Lerda <Lerda@microprocess.com>
To: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: MMU problems on Linux 8xx. (reliability...)
Date: Wed, 14 Jun 2000 11:10:42 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've a PPC823 board working with a recent linux kernel based on monta vista.
When I try complex operation like compiling a kernel on this board, the
kernel
crash after a while. An illegal instruction is generated, linux see
an opcode: *NIP=0, the illegal instruction occur in a glibc-2.1.3 page.
The glibc page is not see properly... This problem seems to occur
only on complex operation, and make this system not reliable.

I also have a PPC750 board working with the same kernel with proper
configuration,
the only differences in code is the MMU part. Linux work properly and
reliably
on this board with the PPC860 software.

if you have see a similar behaviour on you boards, or with differents
processor.
I know that the PPC823 is not 100% compatible with the PPC860, there is
some differences on TLB available etc... And linux seems to be hard coded
for 32 TLB...

If you know how the MMU is handle on linux 8xx, and if you see a similar
behavior
let me know...



Patrick LERDA


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
