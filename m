Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Content-Type: text/plain;
  charset="us-ascii"
From: Arun Dharankar <ADharankar@ATTBI.Com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Serial console ports on systems with no console connected.
Date: Mon, 8 Jul 2002 21:27:16 -0400
MIME-Version: 1.0
Message-Id: <200207082127.16518.ADharankar@ATTBI.Com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings...

This question is common to both ppcboot and ppc-linux.
The ppcboot I am using is 1.1.5 and Linux kernel 2.4.18.

If there is no console connected to the serial console port,
is it true that a thread sending output to it hangs? If this is
ppcboot the bootup process would not proceed? What
consequences would we see on Linux?

I have a MPC8260ADS based board, and see the above
behavior under ppcboot. Under Linux using a BDI debugger
the thread sending output to the console hangs. Perhaps
under Linux we can set the termio modes to have no
flow control, but am not sure if this will solve the problem.

If this is true, is there a clean/proper way to have a setup
such that this hang can be avoided?

Best regards,
-Arun.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
