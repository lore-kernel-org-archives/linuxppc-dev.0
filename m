Date: Thu, 17 Jul 2003 21:46:22 -0400
From: Ryan Boder <icanoop@bitwiser.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Trouble with 2.6.0-test1 on ibook2
Message-ID: <20030718014622.GA5430@bitwiser.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm trying to boot 2.6.0-test1 on my ibook2. I compiled a kernel and it
begins to boot but hangs immediately after the line

openpic: exit

is printed. Or at least seems to hang as the screen stops showing anything
else and just leaves the messages up to that point forever. It also
corrupted my file system so I'm reinstalling now.

Has anyone been running the devel kernel on an ibook2? Can anyone give me
pointers on how to debug or work around this problem when I finish
reinstalling?
--
Ryan Boder
http://www.bitwiser.org/icanoop

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
