Message-ID: <003001bf3194$e2b81960$67f102de@sjzhu>
Reply-To: "Shuangjun Zhu (r44089)" <r44089@email.sps.mot.com>
From: "Shuangjun Zhu" <r44089@email.sps.mot.com>
To: "Linux -Dev" <linuxppc-dev@lists.linuxppc.org>
Subject: Help on initrd
Date: Thu, 18 Nov 1999 15:16:50 +0800
MIME-Version: 1.0
Content-Type: text/plain;	charset="gb2312"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello, everyone

I build a kernel with ramdisk image for a MPC860 board.
While running to display
    "RAMDISK: Compressed image found at block 0"
    "crc error"
it seems that it unzip the ramdisk image failure.
So I debug it, I find that the source zip image which the kernel
will unzip is correct. When it unzip the image, something is wrong.

By the way, when I add some "printk" intructions in 
    "linux/lib/inflate.c"
    "linux/drivers/block/rd.c"
the result of unzip is different.

And I create the ramdisk.image.gz with command
    "gzip ramdisk.image"

Any suggestion is appreciated!
Thanks in advanced!


BRs,
Shuangjun Zhu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
