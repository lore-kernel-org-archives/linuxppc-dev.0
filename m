Date: Sat, 21 Apr 2001 16:51:21 -0400
From: Craig Rodrigues <rodrigc@mediaone.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: gdb hardware breakpoints under Linux PPC?
Message-ID: <20010421165121.B7985@mediaone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

I am debugging a problem with an application that
works under x86 based Redhat Linux 6.2, but
suffers a bizarre memory corruption under LinuxPPC 2000-Q4.
I am using gdb version 5 (gdb 5.05 rpm that comes with LinuxPPC).

I would like to set a hardware watchpoint under gdb
on a certain region of memory, to see why it is getting
clobbered (the element getting clobbered under PPC is
a dynamically allocated structure in a linked list).  Does
gdb 5 support hardware watchpoints under Linux PPC?

Can someone give me an example of how to set a watchpoint?
The gdb manual is a bit vague in explaining this.

Thanks.
--
Craig Rodrigues
http://www.gis.net/~craigr
rodrigc@mediaone.net

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
