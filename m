Message-ID: <20031210032056.82162.qmail@web40411.mail.yahoo.com>
Date: Tue, 9 Dec 2003 19:20:56 -0800 (PST)
From: Raghu <raghu_dk@yahoo.com>
Subject: mpc8xx memory mapped 16550 external UART
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello All,
I have been following the mail,

( Subject: mpc8xx memory mapped 16550 extrenal uart
driver ) posted on the linux-embedded list. I have a
MPC852T based custom board with TL16C752B Dual
external UART Chip with 25 MHz clock mapped on CS6 and
CS7 and a SMC1 UART. Following the intructions in the
mail I am able to get both the SMC1 UART and Dual
external UART configured and working. But I see couple
of issues.
1. When the SMC and Dual UART both are configured with
CONSOLE outputs directed to SMC, the console outputs a
line at a time and probably goes to sleep mode,
displays another line only if I press a "CNTRL-Z" key.
2. The /proc/tty/driver/serial entries shows only SMC
entries.

Warm Regards
Raghu.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
