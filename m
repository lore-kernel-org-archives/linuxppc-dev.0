Message-ID: <A3E34B558F5CD211B4980008C7A4A99001D60ACF@sparrow.eng.gilbarco.com>
From: "Wohlgemuth, Jason" <jason.wohlgemuth@marconi.com>
To: "'Lucinda Schafer'" <lucsch@adaptivemicro.com>,
        "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Software Emulation Kernel Panic
Date: Mon, 12 Jun 2000 15:49:07 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hmmm... Does the kernel completely boot-up?  (As in a shell prompt)  Does
this occur when loading the shell?  What libraries are you using?  Where did
you get those libraries or did you build them yourself?  Or, is this
occurring before the kernel is completely booted?

Jason

-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Lucinda
Schafer
Sent: Monday, June 12, 2000 2:16 PM
To: linuxppc-embedded@lists.linuxppc.org; cort@cs.nmt.edu;
paulus@cs.anu.edu.au
Subject: Software Emulation Kernel Panic



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
