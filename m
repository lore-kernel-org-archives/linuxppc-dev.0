Message-ID: <3BE3A8CB.8050700@elsoft.ch>
Date: Sat, 03 Nov 2001 09:20:27 +0100
From: "David =?ISO-8859-1?Q?M=FCller?= (ELSOFT AG)" <d.mueller@elsoft.ch>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Problem with ldconfig
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello

I have a little problem with the ldconfig tool from glibc 2.2.3.
It runs ok when started under a linuxppc_2.4.10 kernel, but it
throws a segfault when started under a linuxppc_2.4.13-pre6 or later kernel.

Any ideas which change between linuxppc_dev_2.4.10 and
linuxppc_dev_2.4.13-pre6 could cause such a change in behaviour??

Too bad, gdb support is not working in the 405GP part of the
linuxppc_dev kernel.


Dave


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
