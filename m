To: linuxppc-dev@lists.linuxppc.org
Subject: powerpc wmb()
From: Momchil Velikov <velco@fadata.bg>
Date: 18 Nov 2001 14:58:27 +0200
Message-ID: <8766885j7w.fsf@fadata.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


wmb is defined as

#define wmb()  __asm__ __volatile__ ("eieio" : : : "memory")

however, ``eieio'' has no effect on memory, that is
Write Through Not Required, thus I think it should be

#define wmb()  __asm__ __volatile__ ("sync" : : : "memory")

Comments ?

Regards,
-velco

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
