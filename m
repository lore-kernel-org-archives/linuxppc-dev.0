Message-ID: <A109131318C4D1119AC20060088DECE330F374@amwmail.adaptivemicro.com>
From: Lucinda Schafer <lucsch@adaptivemicro.com>
To: linuxppc-embedded@lists.linuxppc.org, cort@cs.nmt.edu,
        paulus@cs.anu.edu.au
Subject: Software Emulation Kernel Panic
Date: Mon, 12 Jun 2000 13:16:02 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings:

On our MPC823-based custom boards, we are experiencing the "Kernel Mode
Software FPU Emulation" panic called from the SoftwareEmulation function in
/linux/arch/ppc/kernel/traps.c in the 2.2.13 kernel. We see this on boot-up
or shortly after.

Could you shed some light on some situations where this may happen? Most
other situations (unimplemented and illegal instructions, floating point,
etc.) would cause the user_mode(regs) call to return a TRUE condition, but
ours apparently returns a FALSE condition, thus the panic. Why does one get
a software emulation exception with the PR bit of the MSR equal to 0?

Any suggestions highly appreciated.

Lucinda Schafer
Staff Software Engineer
Adaptive Micro-Ware, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
