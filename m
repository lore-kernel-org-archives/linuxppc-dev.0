Message-ID: <20020426123803.26947.qmail@web12303.mail.yahoo.com>
Date: Fri, 26 Apr 2002 05:38:03 -0700 (PDT)
From: Miao Qingjun <qjmiao@yahoo.com>
Subject: linux v2.4.18 halted on MPC8260ADS board
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I build a 2.4.18 kernel image for MPC8260ADS board.
But it halts after printing out:

real time clock seems stuck
Calibrating delay loop...


Does someboday also have this problem???

(My modifications to kernel is bd_t struct,
CONFIG_SERIAL_CONSOLE_PORT-->2, SCC_IDX_BASE-->2,
rs_tbl[] SCC2-->SCC1)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
