Message-ID: <D73A25AA6E54D511AD74009027B1110F5BB1A2@ORION>
From: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Cc: "'etux@embeddedtux.org'" <etux@embeddedtux.org>
Subject: good learning experience for Linux
Date: Thu, 22 Apr 2004 11:55:44 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I sent a message earlier today about getting a "swap_dup: Bad swap file
entry 0e18d55c" error.  I found the problem and fixed it and wanted to share
it with people who are still learning this stuff, like myself.

After 2 days of pounding on my head I found the file
Documentation/powerpc/cpu_features.txt  It explained how the file
arch/ppc/kernel/cputable.c has a list of the known powerPC PVRs(processor
version register).  The 8248 was not in there so it was using a default
entry.  That was the cause of my problems.  I added a new entry for the 8248
and all is working.  My lesson was a little research makes things much
nicer.  Lesson learned.

Steve Blakeslee

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
