Message-Id: <200302200741.BAA14158@lists.linuxppc.org>
From: "un" <your_book@sina.com>
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: boot up the linux kernel using vxworks boot ROM(split the  elf )
Mime-Version: 1.0
Content-Type: text/plain
Date: Thu, 20 Feb 2003 15:18:16 +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hello, all:
     I am having trouble loading the image section of the elf file into
ram (vmlinux) with the VxWorks bootloader. The vxworks bootloader could
handle this by the bootloadmodule function(the vxworks lib function)
using ftp to load the image and boot up the kernel.But now we want to
copy the image section of the elf instead of using the function metioned
above. Does someone have a idea on how to handle this ?

un
your_book@sina.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
