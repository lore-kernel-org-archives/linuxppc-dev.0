MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: 2.6.x on 405EP evaluation board?
Date: Tue, 25 May 2004 15:03:56 +0200
Message-ID: <80908CC5B2C9DB47AAF8C77892FCB44315F795@lion.vector.com.pl>
From: "Andriy Korud" <a.korud@vector.com.pl>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, does anybody tried to run 2.6.x on 405EP eval board (actually I have PPChameleon which is very close to it).
For me kernel hangs immediately after uncompressing.
Also I've noticed that asm-ppc/ppcboot.h with board info definition is not included in arch/ppc/platforms/4xx/*.[ch], so I have no idea how it's used.

Thanks in advance,

--

Andriy Korud

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
