Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3B921560.C12A9444@imc-berlin.de>
Date: Sun, 02 Sep 2001 13:17:52 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: What's the purpose of _MACH_8xx?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

I'm just digging through the LinuxPPC sources.

What do we need the define _MACH_8xx for?

Who is assigning new values for it? See include/asm-ppc/processor.h:

#define _MACH_prep      0x00000001
#define _MACH_Pmac      0x00000002      /* pmac or pmac clone (non-chrp)
*/
#define _MACH_chrp      0x00000004      /* chrp machine */
#define _MACH_mbx       0x00000008      /* Motorola MBX board */
#define _MACH_apus      0x00000010      /* amiga with phase5 powerup */
#define _MACH_fads      0x00000020      /* Motorola FADS board */
etc.

It looks like plattform depending. But why then is it in PROCESSOR.h?

Thanks.

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
