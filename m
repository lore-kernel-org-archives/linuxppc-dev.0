Date: Fri, 10 Nov 2000 10:00:14 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: fraher <fraher@pweh.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MVME2604 Problems with MMU
In-Reply-To: <3a0b0db70.46b4@clbdev2.eh.pweh.com>
Message-ID: <Pine.HPX.4.10.10011100955260.19910-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 9 Nov 2000, fraher wrote:

>
>    I've got a 2.2.12 kernel with Gabriel's patches (NFS mounted root),
> and it works beautifully on a MVME2603 board (many thanks, Gabriel).
> However, when I swap out the MVME2603 with a MVME2604, and cause some
> SCSI disk activity, the system crashes with
>
>         end_scsi_request: buffer-list destroyed
>         page fault in interrupt handler, addr=8000000
>         NIP: 08000000 XER: 20000000 LR: C00C67BC REGS: c00ffc48 TRAP: 0400
>         MSR: 40001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
>         TASK = c00fdfe8[0] 'swapper' mm->pgd c00fc000 Last syscall: 112
>                 ...
>         kernel panic: kernel access of bad area pc 8000000 lr c00c67bc address 8000000 tsk swapper/0
>
> The 'page fault' makes me wonder if the 604's TLB miss response differs
> sufficiently to cause the kernel panic.
> Has anyone else seen problems running on 2.2.12 with an MVME2604?
> Are there other patches needed to compensate for the MMU differences
> with the 604e?

I don't have any MVME2604, but I have several MVME2400 with uptimes in
the months range. MVME2400 don't have SCSI, but a 750 has processor with
an MMU very similar to the 604e. Could it be a subtle SCSI/timing problem ?

OTOH, I have reports of working 2604, but I don't remember if it's with
root on NFS or using SCSI.

	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
