Message-ID: <003b01c233ba$961fdf40$8600a8c0@well>
From: "well" <well@zinwell.com.tw>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: can jffs2 on DOC?
Date: Thu, 25 Jul 2002 17:06:39 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

I searched and read all the list but still confusing...
I'm sure my DOC is OK with cat /proc/mtd, but I just can't mount jffs2 image
on DOC
    dev:    size         erasesize   name
    mtd0: 01000000 00004000 "DiskOnChip 2000"

My step to mount jffs2 is:
    mkfs.jffs2 -r /imgdata -o /data.img -e 0x4000
    dd if=/data.img of=/dev/mtd0
    mount -t jffs2 /dev/mtdblock0 /mnt
    and my system hangs.......

These are the questions:
1) Can I mount jffs2 image on DOC?
2) To support jffs2, what kernel MTD options should I enable, I'm not sure
my choice is right?

Any response is appreciate...

W.B.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
