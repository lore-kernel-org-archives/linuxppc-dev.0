Message-ID: <3A2E643E.6EBA2012@drea.dnd.ca>
Date: Wed, 06 Dec 2000 12:08:37 -0400
From: Gavin Hemphill <hemphill@drea.dnd.ca>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: mprotect and SMP
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all:
I'm running a multi-threaded application on an SMP Gemini board
(2.2.18-pre11) which uses the mprotect call to lock pages between the
threads.  If I run the test program on this machine in SMP mode, it
fails (threads tromp on their shared memory locations).  If I run in
uni-processor mode however it works fine.  It also works fine on a dual
processor pentium using a similar version of the kernel.  The question
is... Has anyone seen this sort of behavior and are there any suggested
places to start looking to fix it?  I took a look at the gemini specific
files to see if there were any obvious missing eieio or sync
instructions and so far haven't seen any, but I don't have the
experience to know where else I should be looking.
	Gavin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
