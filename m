Date: Thu,  9 Nov 00 15:48 EST
From: fraher <fraher@pweh.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: MVME2604 Problems with MMU
Content-Type: text/plain
Message-ID: <3a0b0db70.46b4@clbdev2.eh.pweh.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


   I've got a 2.2.12 kernel with Gabriel's patches (NFS mounted root),
and it works beautifully on a MVME2603 board (many thanks, Gabriel).
However, when I swap out the MVME2603 with a MVME2604, and cause some
SCSI disk activity, the system crashes with

        end_scsi_request: buffer-list destroyed
        page fault in interrupt handler, addr=8000000
        NIP: 08000000 XER: 20000000 LR: C00C67BC REGS: c00ffc48 TRAP: 0400
        MSR: 40001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
        TASK = c00fdfe8[0] 'swapper' mm->pgd c00fc000 Last syscall: 112
                ...
        kernel panic: kernel access of bad area pc 8000000 lr c00c67bc address 8000000 tsk swapper/0

The 'page fault' makes me wonder if the 604's TLB miss response differs
sufficiently to cause the kernel panic.
Has anyone else seen problems running on 2.2.12 with an MVME2604?
Are there other patches needed to compensate for the MMU differences
with the 604e?

Bill Fraher
fraher@pratt-whitney.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
