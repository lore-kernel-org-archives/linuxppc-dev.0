Message-ID: <20010710082857.45181.qmail@web14503.mail.yahoo.com>
Date: Tue, 10 Jul 2001 01:28:57 -0700 (PDT)
From: kk <ambarishak@yahoo.com>
Subject: Software Emulation
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I have a MBX MPC823 board. while execve the /sbin/init
from the main.c file I get an error saying


####################
Freeing unused kernel memory : 36k init
Bad emulation init/1
NIP: 300256ac   instruction: 00000000 opcode: 0 A:  0
B:  0  C: 0 code: 0 rc:  0
pte @ 0x300256ac:
(0xc0115300)->(oxc00dd094)->0x01fca9c9
RPN:  01fca    PP: 2 SPS:  1 SH: 0  CI: 0  v: 1
Kernel  VA for NIP c1fca6ac pte @ cxc1fca6ac:
(oxc0115c1c)->(0xc010af28)->0x01fca1cd
RPN:  01fca    PP: 0 SPS:  1 SH: 0  CI: 0  v: 1
Software Emulation init/1 NIP: 300256ac *NIP: 0x0
code: 1Bad emulation init/1

this message repeats continously.

can any one help me,
Thanks,
Ambarish.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
