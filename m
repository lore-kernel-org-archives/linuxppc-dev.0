Message-ID: <3DC634FB.29FAB5D2@bmrtech.com>
Date: Mon, 04 Nov 2002 16:51:07 +0800
From: sjk <jack.sun@bmrtech.com>
Reply-To: jack.sun@bmrtech.com
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Why the gdbserver can't debug step by step?
References: <200210260458.g9Q4wpq15745@ftp1.mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have a very curious problem about EP405 board. I make a kernel image
from ibm-walnut405gp LSP and boot up the Linux kernel on EP405 board. So
I use gdbserver and ppc_405-gdb to debug applications,but only the first
breakpoint could be stopped.Then the
programm will execute to end if you press 'step'. Any other breakpoints
could break the execution.

We have encounter this problem on CSB272 405GP also.I think that
IBM-WALNUT405gp should not have this problem.

Please give me some advice!


Best Regards


Jikun Sun

BMR

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
