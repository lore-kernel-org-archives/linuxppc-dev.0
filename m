Message-ID: <396F289B.7D5705EF@wanadoo.fr>
Date: Fri, 14 Jul 2000 16:50:03 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.4.0-test4 doesn't boot 
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

booting rsync/bitkeeper kernel 2.4.0-test4 gets me into an infinite
loop: At the end of the kernel boot proces, right after "freeing unused
kernel memory", I get a couple of

kmod: runaway modprobe loop assumed and stopped

and then a never ending loop of

kmod: failed to exec /sbin/modprobe -s -k binfmt-4c46, errno=8

Has anyone else seen this or knows what it means?

I have spent many hours changing all kinds of config options, modutils
version, kernel arguments, but I am giving up now. 2.4.0-test3 from 2
weeks ago worked OK.

The number 4c46 exists as PCI_DEVICE_ID_ATI_RAGE128_LF in
include/linux/pci_ids.h, but whether I enable aty128 support or not
makes no difference (I don't have an ATI card).

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
