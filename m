Date: Thu, 18 Feb 1999 17:04:12 +0200 (EET)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: "Marcus H. Mendenhall" <mendenmh@nashville.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Kernel message
In-Reply-To: <v03110700b2e4911c54e4@[129.59.235.1]>
Message-ID: <Pine.LNX.4.04.9902082130430.358-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



 Well since i don't have any IDE drives (PowerWave 604/132) i guess
its not a bug in the IDE driver. I think this will help to narrow
the problem. Sorry for the latest answer btw.

 Kostas Gewrgiou.

On Mon, 8 Feb 1999, Marcus H. Mendenhall wrote:

> This appears (from the mm->pgd reference) to be the same crash I have been
> seeing and posting to the list for a while.  I have been trying to trace it
> down, but not with much success.  It comes from mm/slab.c and may be
> associated with a bad page fault.  Very few people (other than me) have
> been reporting it.  I am seeing it on a G3 rev 2 with 128 MB RAM, running
> off the stock internal IDE drives.  A possible indication is that it might
> be a bug in the IDE driver, causing page fault to fail, since at least one
> person running with SCSI drives has indicated he is not seeing this
> problem.
> 
> Unfortunately, the time I can spend chasing this is small, so unless
> someone with a lot more time starts getting annoyed by it, it won't go away
> soon.
> 
> Marcus Mendenhall
> 
> 
> >I got the following from the kernel, (vger-2.2.0-990201)
> >i was playing with loadkeys at that time, maybe its usefull
> >in the developers maybe not, i have no idea how to turn this
> >to something usefull.
> >
> >  Kostas Gewrgiou
> >
> >NIP: 0182A070 XER: 00000000 LR: 01801EAC REGS: c3483e90 TRAP: 0500
> >MSR: 0000d032 EE: 1 PR: 1 FP: 0 ME: 1 IR/DR: 11
> >TASK = c3482000[277] 'rc5des' mm->pgd c3480000 Last syscall: 78
> >last math c2af0000
> >GPR00: E5E74579 7FFFFA84 9B449F0E 0212050F 73E1FEAA 45086972 7C81A0EE
> >3C571621
> >GPR08: 83F32258 4B765D95 7356167B 313C4254 18253FCD 46DF33E4 07D0C6CC
> >63186637
> >GPR16: CF819E85 799561AC 68D44C12 CD405D72 3D919D13 950149FD 14B690AE
> >A5959BEF
> >GPR24: C987064F CDC150F7 B00426E7 85D30A31 1825F482 3E07D996 61FD48F2
> >4BD08963
> >
> 
> 
> 



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
