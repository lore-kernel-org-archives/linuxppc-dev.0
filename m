Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Subject: Random EMT crashes
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF831E5D0B.E0575821-ON85256EA1.005CAC65-85256EA1.005E95B8@nanometrics.ca>
From: Christopher E Cordahi <chris@nanometrics.ca>
Date: Thu, 27 May 2004 13:13:06 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,

When I run Qt/Embedded applications on my DENX 2.4.24 kernel, on a
MPC852T processor the application tends to randomly crash with EMT trap.

Running gdb on the target causes problems with several drivers,
most noticeably, I can't telnet or ftp in again, however already
established
telnet sessions continue to work.

I've tried running gdbserver on the target, but I can't get it to run.
I've read http://www.denx.de/twiki/bin/view/DULG/DebuggingApplication
guessing as to how to correct a few of the errors on the page.
(should CROSS_COMPILE include the hyphen, the commands require it
to be "ppc_8xx-", but the root directory is "/opt/eldk/ppc_8xx")

Any suggestions where I should look or how to get more information

Chris


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
