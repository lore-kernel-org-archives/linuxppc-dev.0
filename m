Message-ID: <819E3E914E0AD11194DE00805F0D100B0138B852@fbi.infocom.dk>
From: Kim Jørgensen <KIJ@infocom.dk>
To: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: Problem with MPC823 LCD driver
Date: Thu, 4 May 2000 12:38:15 +0200 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi.

I got a custom MPC823E board, and I want to use a LCD display with Linux.
So I removed the HIOX specific line in lcd823.c, and added the LCD frame
buffer to the kernel. But I got a problem; the kernel crashes about 3
seconds after bash gets started, with this message:

init-2.00# Kernel panic: Kernel Mode Software FPU Emulation
Kernel panic: Kernel Mode Software FPU Emulation
Kernel panic: Kernel Mode Software FPU Emulation
Kernel panic: Kernel Mode Software FPU Emulation
Kernel panic: Kernel Mode Software FPU Emulation
Kernel panic: Kernel Mode Software FPU Emulation
Kernel panic: Kernel Mode Software FPU Emulation
Kernel panic: Kernel Mode Software FPU Emulation
Kernel panic: Kernel Mode Software FPU Emulation
Kernel panic: Kernel Mode Software FPU Emulation
Kernel panic: Kernel Mode Software FPU Emulation
Kernel stack overflow in process c02f8000, r1=c02f82d0
NIP: C0054D20 XER: 8000BC7F LR: C0054D20 REGS: c02f8220 TRAP: 1000
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
Machine check in kernel mode.
Caused by (from msr): regs c006ff00 Machine check signal - probably due to
mm fault
with mmu off
NIP: 00001230 XER: A000BC7F LR: C0002544 REGS: c006ff00 TRAP: 0200
MSR: 00001000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
Machine check in kernel mode.
Caused by (from msr):

Can anyone tell me what is wrong, and how to solve this?

I'm using the kernel from mvista and I have enabled Math Emulation. The
kernel runs fine without the LCD driver.
I have used the LCD driver on a PRXL board without any problems.

---
Kim Jorgensen


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
