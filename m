From: "Stefano Coluccini" <s.coluccini@caen.it>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Bogus interrupt
Date: Mon, 26 Feb 2001 12:54:19 +0100
Message-ID: <NDBBIFIMCKPOADMAJOKMEEEOCPAA.s.coluccini@caen.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi everyone,
  I'm trying to run kernel 2.5 on Motorola MVME5100 and, after the sti
istruction in start_kernel, the kernel hangs due to a spurious interrupt.
(Bogus interrupt -1)
Is this a well-known problem also in other ports ? or have anyone of you a
suggestion to solve this ?

Thaks in advance.
Stefano.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
