From: ghannon@cspi.com
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <85256C69.0053EA72.00@pine.cspi.com>
Date: Wed, 6 Nov 2002 10:32:12 -0500
Subject: Using intrd with 2.4.20-pre2
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm getting stuck when mounting the initrd. This using the
ppc 2.4 galileo tree at 2.4.20-pre2.

I get as far as "VFS: Mounted root (rootfs filesystem)"

On linuxppc_2.4.11_devel  I would see

"VFS: Mounted root (romfs filesystem) readonly"

The romfs is found and uncompressed successfully.
Is there a specific  root=/dev/something  I am supposed to
pass (build) into the kernel cmdline? (no console/keybd)
I've tried root=/dev/ram0,  root=/dev/initrd and no root
clause all with no success.

I've uncompressed and mounted the file on a loopback
device on my Mac, so it is not corrupted.
It mounts as type romfs, not ext2,  is that OK?

Thanks,
Gary Hannon


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
