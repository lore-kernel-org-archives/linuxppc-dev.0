Message-ID: <20030526061601.60728.qmail@web12701.mail.yahoo.com>
Date: Mon, 26 May 2003 08:16:01 +0200 (CEST)
From: =?iso-8859-1?q?vincent=20poirson?= <poirsonv@yahoo.fr>
Subject: [MPC8260] accessing I/Os while MMU is off
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I want to change my PDATC value while in
HardwareInterrupt code (in kernel/head.S) where MMU is
off. So I simply do :
li r13, 0x0d50
addis r13, 0xf001
stw r14, 0(r13)
// where 0xf0010d50 is my PDATC adress and r14 the
value I want to store
I do not understand why my kernel crahes and goes in
machine exception. Surprisingly, I can change PDATC
with BDI2000 but not with assembler code. Is this an
adress translation problem ?
Am I missing something obvious ? Any help will be
appreciated.

Thanks in advance.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
