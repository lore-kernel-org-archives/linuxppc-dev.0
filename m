From: John Dowd <jdowd@sympatico.ca>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Kernel Make files - a stupid question...
Date: Sat, 24 Feb 2001 14:36:23 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
MIME-Version: 1.0
Message-Id: <01022414362300.18022@allo-moi>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm using Bitkeeper to manage a repository for my kernel source code. I'm
using the HardHat version of the kernel 2.4.x.

Since its been put under the bitkeeper manager each directory under the
repository has a directory called SCCS and the top one has a directory called
"Bitkeeper".

When I go to build the kernel, the make file walks into the SCCS directories
and tries to build the files there and I get all sorts of errors and warnings.

I had thought that gnu - Make knew about both RCS and SCCS repositories and
unless told otherwise, ignored them?

Does anyone have a solution for this?

								Cheers!!
--
-----------------------------------------------------------------
    "To Err is human, to forgive is not company policy!"
                                                          John Dowd
                                                          jdowd@sympatico.ca

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
