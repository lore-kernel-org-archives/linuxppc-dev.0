To: linuxppc-dev@lists.linuxppc.org
Subject: Ported SGI kdb (kernel debugger) patch to PPC
From: Daniel Berlin <dberlin@redhat.com>
Date: 09 Mar 2001 23:46:01 -0500
Message-ID: <m2g0gmjkom.fsf@dynamic-addr-83-177.resnet.rochester.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I got amazingly tired of staring at xmon, because i find it almost
worthless compared to SGI's kdb, and since I use the XFS tree anyway
(all but one of my FS's are XFS), which has kdb in it, I ported kdb to
PPC today.

Works great.
The patch is a little large (~200k), so i wanted to see if anyone else
was interested in it.

I reused xmon's lowlevel input/output routines, and the xmon NMI stuff
(I just have an xmon_irq function in the kdb support code, which calls
kdb instead).

Among other very nice features, kdb lets you see symbols, rather than just
addresses, in both instruction dumps, backtraces, etc.
It also lets you do backtraces of other processes, including user
processes, and dumps of user memory, etc. In addition to
all the normal features of a good kernel debugger (8 billion forms of
breakpoints and stepping, extensible through modules, etc).
It's just a lot nicer to use than xmon, IMHO.

--Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
