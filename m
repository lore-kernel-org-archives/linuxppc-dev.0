Message-ID: <20083A3BAEF9D211BDB600805F8B14F3010A15A6@NTSERVER>
From: Tzahi Oved <tzahio@voltaire.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: ppcboot 1.1.4 & linuxppc 2.4.10
Date: Sun, 24 Feb 2002 21:16:15 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="windows-1255"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I'm trying to put together the ppcboot and linuxppc on the Galileo EV64260.
After succeeding in loading the ppcboot, I'm tring to load the linuxppc in
image mode (after using the mkimage utility on the vmlinux.gz file). After
the ppcboot decompresses the kernel image it get's stack and doesn't even
get to the Linux version printing.
Any suggestions ??
thanks

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
