Date: Mon, 03 Dec 2001 10:00:00 -0700
From: Okehee Goh <ogoh@asu.edu>
Subject: Debugging message through FDC37C672-COM of MBX860??
In-reply-to: <3C06705B.15147A92@mvista.com>
To: linuxppc-embedded@lists.linuxppc.org
Message-id: <CPEELCODKANPCLBCAGOFCEKPCAAA.ogoh@asu.edu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,
I'm so sorry about this question.

I want to print out debug messages to console monitor from the
application loaded at MBX860 through EPPC-Bug. I was supposed to use
EPPC-Bug's system call for this purpose. But it wasn't possible because my
application overlap
all exception codes and stack. And then I tried to use SMC1 or SMC2's UART
for this purpose. But it's not working.

The port status is the following.
------------------
EPPC-Bug>pf
Current Port Assignments:  (LUN: Device-Name Port-Name)

00: FDC37C672-COM     COM1              (Console)

01: MPC8XX-SMC        SMC2

02: MEMORY            CHNL0

------------------------

According to MBX manual, SMC1 is used as console port.

If it's true, COM1 is using SMC1?

So, I thought I must use SMC'1 UART to print out to a console. Is it
correct?

I tested the application using SMC1' s UART

 by applying a SMC's UART application note provided by Motorola's
website(MPC860COD17).

But It doesn't seem to work. I can't see anything from a console after
executing this test application.



Thank you any help.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
