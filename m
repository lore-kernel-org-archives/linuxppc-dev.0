From: bharat <bharat@coraltele.com>
To: "'linuxppc-embedded'" <linuxppc-embedded@lists.linuxppc.org>
Subject: regarding kernel access of bad area
Date: Tue, 15 Jun 2004 11:05:27 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <22347859.1087277692203.JavaMail.administrator@RnDserver>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi everyone
                   i am trying to port hardhat linux for our custome hardware
i donot use a bootloader instead i used uncompressed(vmlinux) image and a
self made utility which download the kernel  into  the ram and transfer the
control to it kernel gets executed  and mount the NFS file system from my
host as soon as it tries to execute the /sbin/init or /bin/init or any other
user program init it gives the following error
 Kernel panic: kernel access of bad area pc c0014198 lr 1 addr
ess FFFFB104 tsk swapper/0   In swapper task - not syncing
what should i do
bye
bharat


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
