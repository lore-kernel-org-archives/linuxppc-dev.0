Date: Wed, 17 Nov 1999 03:50:43 +0000 (   )
From: John Buswell <johnb@one.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: mkext2 on a mac ide disk
Message-ID: <Pine.LNX.3.96.991117034438.17776A-100000@shell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hi

I have a disk image of a small linux install for the iMac. I have an iMac
DV's ide HDD mounted in my x86 linux box, I recompiled pdisk, can
modify/create/delete partitions, but I cannot create ext2 file system with
mke2fs. I get :

mke2fs 1.15, 18-Jul-1999 for EXT2 FS 0.5b, 95/08/09
/dev/hdc10: Invalid argument passed to ext2 library while setting up
superblock 

Partition map (with 512 byte blocks) on '/dev/hdc'
 #:                type name              length   base     ( size )
 1: Apple_partition_map Apple                 63 @ 1
 2:      Apple_Driver43*Macintosh             54 @ 64
 3:      Apple_Driver43*Macintosh             74 @ 118
 4:    Apple_Driver_ATA*Macintosh             54 @ 192
 5:    Apple_Driver_ATA*Macintosh             74 @ 246
 6:  Apple_Driver_IOKit Macintosh            512 @ 320
 7:       Apple_Patches Patch Partition      512 @ 832
 8:           Apple_HFS untitled         3932099 @ 1344     (  1.9G)
 9:           Apple_HFS untitled 2       1844006 @ 3933443  (900.4M)
10:     Apple_UNIX_SVR2 root              307200 @ 5777449  (150.0M)
11:          Apple_Free Extra           13856615 @ 6084649  (  6.6G)
Device block size=512, Number of Blocks=19941263 (9.5G)
DeviceType=0x0, DeviceId=0x0
Drivers-
1: @ 64 for 22, type=0x1
2: @ 118 for 36, type=0xffff
3: @ 192 for 20, type=0x701
4: @ 246 for 33, type=0xf8ff

------------

what I am trying to do is create a bootable root partition on the iMac DV
so that it will boot into linux.. I have it booting, just need the actual
root partition there for it to work :)

any ideas?

thanks


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
