From: jlhagen@collins.rockwell.com
Subject: mvme2604 - using Gabriel's patches. NFS questions.
To: linuxppc-embedded@lists.linuxppc.org
Date: Wed, 8 Nov 2000 16:29:43 -0600
Message-ID: <OFEA5E744C.0F7B4EBE-ON86256991.007989AD@collins.rockwell.com>
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have two mvme2604 boards that are up and running with root mounted NFS
using Gabriel's patches against 2.2.12 kernel. The boot messages for the
boards always report " VFS: Mounted root (NFS filesystem) read-only".  Not
knowing NFS that well, is there a way I can change it so the boards mount
the file system as read/write? I do have the nfs sever /etc/exports file
set for "  /tftpboot/192.168.1.5      vme(rw, no_root_squash)"  read/write
as I understand it. Might be a stupid question but I need to be
enlightened.

With this same set up I have been playing with Gabriel's patches against
2.4-test series kernels and I usually get the following result from the
boot messages:

kmem_create: Forcing size alignment - nfs_fh
VFS: Cannot open root device "" or 08:01
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 08:01
Rebooting in 180 seconds

I'm passing the root=/tftpboot/<IP address> in on the "Load:" line. This
works just fine for the 2.2.12 Gabriel patched kernels. The NFS server is
an intel running a  fresh 2.2.17 kernel that I built, it's not running the
provided Redhat patched kernels. Is this an NFS compatibility problem
between the 2.4 series kernels and the 2.2 series???? I'm at a loss???

Thanks
John

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
