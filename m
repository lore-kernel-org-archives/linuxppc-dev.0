Message-ID: <3A701C2C.60008@galileo.co.il>
Date: Thu, 25 Jan 2001 14:29:32 +0200
From: Rabeeh Khoury <rabeeh@galileo.co.il>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Max bus
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,

I'm trying MAX Bus protocol on Galileo evaluation board and I'm getting
the following errors -

VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 176k init
floating point used in kernel (task=c022e000, pc=944)
floating point used in kernel (task=c022e000, pc=c01e1c60)
floating point used in kernel (task=c022e000, pc=944)
floating point used in kernel (task=c022e000, pc=c01e1c60)
floating point used in kernel (task=c022e000, pc=944)
floating point used in kernel (task=c022e000, pc=c01e1c60)
floating point used in kernel (task=c022e000, pc=944)
floating point used in kernel (task=c022e000, pc=c01e1c60)
floating point used in kernel (task=c022e000, pc=944)
floating point used in kernel (task=c022e000, pc=c01e1c60)
floating point used in kernel (task=c022e000, pc=944)
floating point used in kernel (task=c022e000, pc=c01e1c60)
floating point used in kernel (task=c01a0ff0, pc=944)
NIP: 00000F28 XER: 00000000 LR: C000638C REGS: c01a2eb0 TRAP: 0400
floating point used in kernel (task=c01a0ff0, pc=944)


After these errors the kernel hangs !

Does Linux support MAX Bus ?
Should I add new flags to the compiler ?


Regards,
Rabeeh


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
