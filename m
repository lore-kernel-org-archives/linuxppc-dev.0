Message-ID: <2044A9F15B38D211A89900104BD36C02381B4B@thebank.audesi.com>
From: Clinton Lam <clinton@AudeSi.com>
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: mpc8xx-2.2.13 booting problem
Date: Thu, 3 Feb 2000 10:12:33 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am new to the embeded linux. I am trying to port mpc8xx-2.2.13 kernel to
our custom board, called Touchstone. It is a reference design based on
mpc823, which has 32 Mbyte of SDRAM, and 4 Mbyte of flash.

So far, I've developed a network bootloader, which downloads the zImage to
the target. I am at the stage where I can unzip the kernel image to address
location 0x0, and jump to it. Then, inside the routine "start_kernel", I am
able to get the console up and have the linux banner partially displayed at
the cosole.

However, after some more kernel initialization in "start_kernel", the
program stuck in a routine called "sti()". I've debugged through this
routine (it is an assembly routine) , and it seems that it is looping
forever inside the routine. I know that the routine is trying to set the EE
bit in MSR, and also doing some thing with ppc_n_lost_interrupts, which I
don't quite understand.

Does anyone have any idea what is wrong with my port? Can someone explain to
me what is the purpose of this "sti()" routine, what are the possible cause
for it to hang?

Your response is greately appreciated!

Thanks in advance.

Clinton Lam

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
