Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: 18 Sep 2002 01:31:37 -0000
Message-ID: <20020918013137.15713.qmail@webmail6.rediffmail.com>
MIME-Version: 1.0
From: "sanjay k k" <fren00@rediffmail.com>
Reply-To: "sanjay k k" <fren00@rediffmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: ppc_405-gdb + Segmentation fault (core dumped)
Content-type: text/plain;
	format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi ,
I was trying to debug the kernel with the help of BDI, but
couldn't do so as gdb is dying itself.
I am using monta vista cross-compiled gdb. Here what i do to debug
the kernel.

1. boot the board (I am using ppcboot)[Board is connected with
BDI]
2. After that I start the ppc_405-gdb on host.
3. Enter C to continue.
4. Then I press CTRL-C to stop the gdb , then it stops the
kernel.
5. Now I try to add the symbol file (vmlinux).
When i do the 5th step , my gdb dies , it says :
Reading Symbols from vmlinux.... Segmentation fault (core
dumped).

Thankx
Sanjay

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
