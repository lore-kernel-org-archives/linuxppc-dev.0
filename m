Message-ID: <407C1601.2080100@imc-berlin.de>
Date: Tue, 13 Apr 2004 18:32:01 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: kfree_skb on hard IRQ ???
References: <407C065A.9010004@imc-berlin.de>
In-Reply-To: <407C065A.9010004@imc-berlin.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steven Scholz wrote:
>
> Hi there,
>
> my HERMES-II drivers causes a lot of
>
> Warning: kfree_skb on hard IRQ c38c2168
>
> messages.
>
> What do they mean?

And what means

alloc_skb called nonatomically from interrupt c00eb8d0
kernel BUG at skbuff.c:174!
Oops: Kernel Mode Software FPU Emulation, sig: 8
NIP: C00E065C XER: 00000000 LR: C00E065C SP: C016BC80 REGS: c016bbd0 TRAP:
1000    Not tainted
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0169fa0[0] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
...
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
  <0>Rebooting in 10 seconds..

???

Thanks a million!


--
Steven Scholz

imc Measurement & Control               imc Meﬂsysteme GmbH
Voltastr. 5                             Voltastr. 5
13355 Berlin                            13355 Berlin
Germany                                 Deutschland

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
