From: kd@flaga.is
Subject: atomic.h
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF92646E3F.5C927AF4-ON00256929.00341500@flaga.is>
Date: Thu, 27 Jul 2000 09:33:19 +0000
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Is there any "real" reason that the implementation of the atomic functions
in asm-ppc/atomic.h are included in #if 0 ....#endif (besides mixing of
atomic_t  and int types in declarion and definition of the functions)?

I am using linux 2.2.5 and 2.2.13 for the MPC823 and both versions are the
same.

Thanks,

K.D.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
