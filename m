Message-Id: <4.3.1.2.20000803192448.00adb470@pop3>
Date: Thu, 03 Aug 2000 19:37:38 +0200
To: linuxppc-dev@lists.linuxppc.org
From: yuval <yuval@jungo.com>
Subject: Upload an image file
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,
I'm trying to install linux on ppc.
I've compiled the kernel and trying to take the image (in
arch/ppc/mbxboot/zImage) and transfer it to the "box", but if I'm using
objcopy to transform it to srecords, the outcome is a file without the
compressed linux image and when the gunzip start, it crash.
if I manually set the image section to be "alloc,load" the section is loaded
to the srecord file but not in the right offset.
I did understood that the srecords convert the addressed from the address
(vma, lma) and not from the offset (the offset is what the make file assign
to the ZIMAGE_OFFSET). this is also the case when I'm using Ice probe to
transfer the image.

Any help would be greatly appreciated.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
