Message-ID: <39DCEA5A.2E9DDE3C@emc.com>
Date: Thu, 05 Oct 2000 16:53:46 -0400
From: Zhaobin Zhu <zzhu@emc.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Linux boot failed on Sandpoint under baudrate 38400
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Anybody tried booting Hardhat linux on Sandpoint/603e/755/7400
under Baudrate 38400 ?

On my sp7400, the boot is ok under 9600, but gives garbled message
after "Now booting the kernel" under 38400.

I change baudrate in arch/ppc/boot/ns16550.c

Does the kernel change the baudrate in other place ?

Thanks,

--
 Zhaobin Zhu
 zzhu@emc.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
