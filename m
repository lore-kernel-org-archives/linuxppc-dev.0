Message-ID: <3BA77B15.2090707@cray.com>
Date: Tue, 18 Sep 2001 11:49:25 -0500
From: David Updegraff <dave@cray.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: applications in HHL 2.0, 405GP
References: <200109071118.EAA14228@krakatoa.gigabitnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi.

I need Tcl/Expect in our environment and HHL20 does not appear to include it,
and bringing it over from other PPC distributions (eg. Debian) just traps out
with "Illegal Instruction" ... which I presume is some floating point
instruction which the 405GP lacks.

My approach is to go get the Tcl/Expect sources and start building away..

Is there a better approach?  Is there a repository anywere where
PPC -msoft-float RPMs live that I could borrow from/contribute to?

Anyway, I thought it was the "theory" that the kernel was trapping the
float instructions and emulating them...???

Please advise. Thanx.

--
Dave Updegraff / dave@cray.com / 218-525-1154


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
