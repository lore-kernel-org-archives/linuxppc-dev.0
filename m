From: ghannon@cspi.com
To: linuxppc-dev@lists.linuxppc.org
Message-ID: <85256C8E.0071F917.00@pine.cspi.com>
Date: Fri, 13 Dec 2002 15:51:57 -0500
Subject: pcibios_fixup
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


We are developing a custom 74xx based board with a gt64260b.
On board is a device we are acessing through pci0 on the gt64260b.

I've noticed that in the device's configuration header, the cache line
size parameter is not what I want it to be.   Is pcibios_fixup the
place in the kernel to make such a change?
(that is in my specific platform_setup.c file)
Or, should I do it in the
driver that uses that device?

Thanks for any direction.

Gary Hannon
CSPI
ghannon@cspi.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
