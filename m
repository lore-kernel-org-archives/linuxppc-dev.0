Message-ID: <20031120145529.50850.qmail@web41415.mail.yahoo.com>
Date: Thu, 20 Nov 2003 06:55:29 -0800 (PST)
From: Jeff Stevens <jsteve17@yahoo.com>
Subject: Kernel 2.4.23 Problems
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I recently tried upgrading to the 2_4_devel kernel
from the DENX CVS repository (2.4.23 kernel).
However, when I try to run the new kernel, I don't see
anything after it uncompresses the kernel.  I can boot
the 2.4.4 kernel without any problems, and have
basically all of the same kernel configuration in
2.4.23 as in 2.4.4.  I have tried both with and
without the clocks_in_mhz environment variable set,
and I have updated the rpxclassic.h file (in
arch/ppc/platforms) to include asm/ppcboot.h as I had
to do in 2.4.4 (although rpxclassic.h is under
include/asm-ppc in 2.4.4). There is one option (which
I think is the culprit) that I don't have in the
2.4.23 kernel that is in the 2.4.4.  That is the "Use
SCM1 for UART" option under the "MPC8xx Options"
portion of the kernel configuration.  The base option
exists ("Use SMC1 for UART"), but there is no other
options when I select that, as there are for the "Use
SMC2 for UART" option and as it does have in 2.4.4
(such as "Use SMC2 for Console" etc.).  Is there a
patch that will give me these options?  Could someone
please help!  I have tried all of the UART options
(SMC1, SMC2, and all of the SCCx UARTs) with no luck.
I'm at a loss now, and don't know what else to try.

Thanks in advance,
   Jeff


Free Pop-Up Blocker - Get it now
http://companion.yahoo.com/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
