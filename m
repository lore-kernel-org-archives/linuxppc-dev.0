Message-ID: <01C0B6AE.0AC9DCA0@milkweed.cspi.com>
From: Brian Waite <bwaite@cspi.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: initrd on PPC
Date: Tue, 27 Mar 2001 11:06:57 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Has anyone been successful in bringing up a zImage.initrd under 2.4 PPC. I am using a Motoroloa 2400 with a zImage.initrd and it looks like there is no way this can be working. initrd_start and initrd_size are not set correctly when I get into arch/ppc/kernel/setup.c. We have been working great under 2.2 but I am tring to bring it up under 2.4.3pre3 and hitting a roadblock. Has the entire logic changed from 2.2 -> 2.4 here or is it just really broken? We are hoping to get it working today but we are putting 2.2 code back into the 2.4 tree to make this happen I am a little afraid this is the bass-ackwards way to do this. Has anyone just gotten this to work out of the box?

I have checked all the configs I can think of
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096   <-- We are below this
CONFIG_BLK_DEV_INITRD=y
# CONFIG_CRAMFS is not set
# CONFIG_RAMFS is not set
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=y
CONFIG_ROMFS_FS=y


Brian Waite

Looking for a TeraFLOP in a closet?
www.fastcluster.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
