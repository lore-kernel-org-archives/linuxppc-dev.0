MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: ggc 3.3.x for kernel compile?
Date: Thu, 13 May 2004 16:57:22 +0200
Message-ID: <80908CC5B2C9DB47AAF8C77892FCB44315F76C@lion.vector.com.pl>
From: "Andriy Korud" <a.korud@vector.com.pl>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi?
Does anybody use gcc 3.3.x for kernel compile especially for ppc405?
I have the following problem:
after the following code:

struct inet_protocol *inet_protos[MAX_INET_PROTOS];

in kernel compiled with 2.95 I have
inet_protos: 0xc01b097c, inet_protos[0]: 0x00

and in kernel compiled with 3.3.3:
inet_protos: 0xc01b097c, inet_protos[0]: 0xffffffff

which cause kernel oops. Kernel is current CVS from DENX.

Any ideas?

thanks in advance,

--

Andriy Korud

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
