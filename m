Message-ID: <XFMail.20010807093111.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
Date: Tue, 07 Aug 2001 09:31:11 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: linuxppc-dev@lists.linuxppc.org
Subject: FW: floating point exception problem on apple PPC
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


-----FW: <CA256AA1.0019E765.00@d73mta01.au.ibm.com>-----

Date: Tue, 7 Aug 2001 10:10:05 +0530
Sender: linux-kernel-owner@vger.kernel.org
From: mdaljeet@in.ibm.com
To: linux-kernel@vger.kernel.org
Subject: floating point exception problem on apple PPC

Hi,

I am using SuSE Linux 7.1 with kernel version 2.4.2 on Apple G4 dual
processor PPC machine.

Due to setting of MSR[FE0] and MSR[FE1] bits in the 'FPUnavailable'
exception handler, a user application that tries to do floating point
arthemetic with large floating point values gets a SIGFPE signal. By
setting the FPSCR register with appropriate value in the SIGFPE signal
handler the program runs fine with the expected values.

Now, what happens is that when I run such program (that does floating point
arthemetic with large floating point values) continuously for hours, the
other applications running on the system sometimes get terminated after
receiving a SIGFPE signal while my floating point program runs fine. Is
that due to some kernel problem or loading the FPSCR in the SIGFPE signal
handler of a process can lead to this problem?

regards,
Daljeet.



--------------End of forwarded message-------------------------

Bye.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
