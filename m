Message-ID: <406C1E50.1010806@intracom.gr>
Date: Thu, 01 Apr 2004 16:51:12 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: [OT?] Unimplemented instructions on a G5?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello

I've recently came across a very strange problem.

I have some PPC code with some inline assembly for implementing
saturated arithmetic.

The code runs fine on a 8xx target and on the G4 development host.

When I upgraded to a G5 running Gentoo the same code terminates
with an illegal instruction trap.

The offending instruction is the seemingly harmless:

  mcrxr crX

   (Move to condition register from XER).

Does anyone have any idea if IBM left this instruction
unimplemented. Searching the docs I've found nothing.

It's not a deal-breaker but it is inconvinient to not be
able to run the target binaries on the host.

If it is unimplemented any idea of how hard it will be to
trap and emulate it?

Regards

Pantelis


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
