Message-ID: <03e401c407a5$2bd19410$3000a8c0@foundation>
From: "Stuart Yoder" <stuart.yoder@conformative.com>
To: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Subject: version of gcc
Date: Thu, 11 Mar 2004 14:12:25 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The 2.4 kernel Documentation/Changes file has the following note:

The recommended compiler for the kernel is gcc 2.95.x (x >= 3), and it
should be used when you need absolute stability. You may use gcc 3.0.x
instead if you wish, although it may cause problems. Later versions of gcc
have not received much testing for Linux kernel compilation, and there are
almost certainly bugs (mainly, but not exclusively, in the kernel) that
will need to be fixed in order to use these compilers.

Is this still true?  The comment appears to be > 2 years old.  I am running
gcc 3.2.2 and wondering if I'm asking for trouble.   Do I really need to
revert back to an old compiler?

Thanks,
Stuart


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
