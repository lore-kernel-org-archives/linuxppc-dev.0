Message-ID: <3DD4E4D3.4030805@motorola.com>
Date: Fri, 15 Nov 2002 12:13:07 +0000
From: John Traill <john.traill@motorola.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: linuxppc-2.5 / Sandpoint X2
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm having problems getting linuxppc-2.5 running on an X2 Sandpoint system. Firstly there are a couple of failures
during the build relating to changes in the interrupt handling. I've made the obvious changes in sandpoint_setup.c

openpic_init(1,0,NULL,-1) -> openpic_init(0)
i8259_poll() -> i8259_irq(regs)

The kernel boots, mounts file system etc...  but after "Freeing unused kernel memory: 96k init" no prompt - Initial
debug shows that the kernel is executing some of the interrupt routines (sandpoint_get_irq(), openpic_irq() etc ).
However I'm not sure if this is indicative of an error in the changes above or just the fact that the kernel isn't doing
anything else but service irq's.

Any help/pointers would be gratefully received.

--

Regards, John


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
