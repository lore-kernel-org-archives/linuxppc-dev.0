Message-ID: <20021022020305.41175.qmail@web21007.mail.yahoo.com>
Date: Mon, 21 Oct 2002 19:03:04 -0700 (PDT)
From: kas turi <inox_kas@yahoo.com>
Subject: bash 2.05 not running on MPC8250 processor
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi
  We are having two custom boards. On one board we are
using 8260 processor. On this board I am able to run
the timesys kernel. I am able to run all the
applications on this board. On the second board we are
having 8250 processor. On this board the kernel boots
up and the init process tries to run bash but, bash
crashes. I am getting a floating point exception. I
downloaded the bash code and I compiled and linked
statically and made sure that there are no floating
point instructions. Even the new compiled doesnt run
on the 8250 board. Is anyone successfully able to run
bash on the 8250 board?.
 Thanks in advance.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
