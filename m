Message-ID: <005701c1cad8$d397eb60$6649a8c0@LEIYINGDU>
From: "Leiying Du" <ldu@solectek.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Debug kernel ELF using SDS single-step debugger
Date: Wed, 13 Mar 2002 13:48:35 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


When I run the kernel ELF, I always get this error message "Couldn't find
4096 bytes at 4096 alignment". It's printed out in  __initfunc(void *
find_mem_piece(unsigned size, unsigned align)).   ( The kernel runs Ok from
the flash memory.) Does anyone know the reason? Should I initialize the MMU
with the debugger? Thanks.

Leiying


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
