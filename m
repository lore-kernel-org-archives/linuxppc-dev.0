From: Ryan Nielsen <ran@krazynet.com>
Date: Wed, 6 Oct 1999 22:54:26 -0700
To: linuxppc-dev@lists.linuxppc.org
Subject: busmaster/latency for video
Message-ID: <19991006225426.A192@gondolin.asf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


PCI_COMMAND_MASTER is not enabled and latency = 0 for the ultimate rez video card, and pci_write_config_*
do not change them. latency = 32 and mastering is enabled for all the other cards in the machine,

should they be enabled ?

a machine check happens when calling sys_idle after using offb with the ultimate rez.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
