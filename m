Subject: re: meaning of error
To: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Message-ID: <OF64F8CDF6.4E343A28-ON86256B99.00131E07-86256B99.00135617@rchland.ibm.com>
From: "David Boutcher" <boutcher@us.ibm.com>
Date: Thu, 11 Apr 2002 22:31:11 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Any help would be appreciated.  In the error "Kernel panic: VFS: Unable
to
> mount root fs on 01:01" what does the 01:01 stand for?  I've also seen
00:00
> and 01:00.

Devices are identified by a major number and minor number.  This says the
kernel is looking on major 01 minor 01 for a file system....and not finding
one. Usually you fix this by adding a "root=/dev/sda1" (or whatever) kernel
parameter when you boot.  The kernel doesn't "search" for a root file
system....it basically expects it to be where you tell it.

Dave Boutcher
Senior Technical Staff Member
iSeries Linux Development and Architecture


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
