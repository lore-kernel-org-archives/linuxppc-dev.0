From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Robert P. J. Day" <rpjday@mindspring.com>,
	"Embedded Linux PPC list" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: partial boot progress with 2.6 kernel and MPC850 board
Date: Sun, 9 May 2004 12:40:48 +0200
Message-ID: <BCEFJBPJCGFCNMMMIDBHMEOBCFAA.Joakim.Tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <Pine.LNX.4.58.0405082115200.25141@localhost.localdomain>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Using anticipatory io scheduler
> RPX Lite or CLLF flash device: 2000000 at fe000000
> Oops: Kernel Mode Software FPU Emulation, sig: 8 [#1]
> NIP: 00000200 LR: C010A270 SP: C04D3CF0 REGS: c04d3c40 TRAP: 1000    Not
> tainted
> MSR: 00000000 EE: 0 PR: 0 FP: 0 ME: 0 IR/DR: 00
> TASK = c04d9870[1] 'swapper' THREAD: c04d2000Last syscall: 120
> GPR00: 00F000F0 C04D3CF0 C04D9870 C01C2490 00000000 00000000 C04D3D58
> 00000000
> GPR08: 00000000 C3050000 00000004 00000004 C04D3D58 FA202210 814D9590
> 04294A49
> GPR16: 800C1000 86A18F36 01243440 8099A0B1 32901AA8 14C18630 4CCA2080
> 181021E0
> GPR24: 0E54A064 44810080 C04D3D58 00000002 C01C2444 C01C2490 00000000
> 00000004
> Call trace: [c010a270]  [c010a00c]  [c0109f38]  [c0103c60]  [c0102788]
> [c01d58
> Kernel panic: Attempted to kill init!
>  <0>Rebooting in 180 seconds..

Looks like you got an MachineCheck that could not be handled.
NIP is 0x200, which is the Machine Check exception vector.
Try changing the MachineCheck exception as I wrote earlier.
Then you should get a better fault indication.

     Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
