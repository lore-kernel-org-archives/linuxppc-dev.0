Message-ID: <31912.1091207368623.SLOX.WebMail.wwwrun@donald.sysgo.com>
Date: Fri, 30 Jul 2004 19:09:28 +0200 (CEST)
From: Pavel Bartusek <Pavel.Bartusek@sysgo.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: nfs server not responding
Cc: mporter@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,

I am using the latest kernel from bk://source.mvista.com/linux-2.5-ocp
on the Ocotea board and the default Ocotea config file which comes with
the kernel plus the following
CONFIG_CMDLINE="ip=on console=ttyS0,115200 root=/dev/nfs rw"
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y

I have root filesystem mounted via nfs. During writing of a file occurs
the
following error:
bash-2.05a# dd if=/dev/zero of=/x bs=1M count=10
nfs: server 129.168.1.87 not responding, still trying

>From this state is not possible to recover and get the shell prompt. The
problem
occurs only in the half duplex mode. When the ethernet operates at full
duplex
all seems to be OK. The same problem is on the Ebony. My investigation
points it is caused by the ethernet driver. The old 2.4.21 ppc kernel
worked fine with the Ebony.

Pavel Bartusek
SYSGO AG


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
