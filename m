Message-ID: <37B96348.DEB3E810@agelectronics.co.uk>
Date: Tue, 17 Aug 1999 14:27:36 +0100
From: Adrian Cox <apc@agelectronics.co.uk>
MIME-Version: 1.0
To: Neil Blackwood <nb@terrafix.co.uk>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: BOOT PROBLEMS WITH KERNEL 2.2.5 FOR MBX821
References: <002b01bee8a2$78d4a3a0$67c13ec3@everyone>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Neil Blackwood wrote:
> NIP: 00000000 XER: 00000000 LR: C00E3D68 REGS: c013ddf0 TRAP: 0400
> MSR: 08209032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> TASK = c013c000[1] 'swapper' mm->pgd c00cb000 Last syscall: 120
> last math 00000000

Find out what function contains address 0xc00e3d68 by looking in the
System.map file. It's probably something board specific, as generic
Linux kernel code normally ends up at lower addresses. Then, try and
work out why it has made a call through a NULL function pointer.  The
important information for you is NIP for the instruction address and LR
for the address the last subroutine call came from.

- Adrian Cox, AG Electronics

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
