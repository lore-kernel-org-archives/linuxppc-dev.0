Mime-Version: 1.0
Message-Id: <p06020400bbf71e3a8e09@[192.168.0.23]>
Date: Sat, 6 Dec 2003 00:50:38 -0500
To: <linuxppc-dev@lists.linuxppc.org>
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: error compiling bttv
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Trying to add video4linux. When I build for bttv, I get this error in
the kernel compile:

drivers/media/media.o(.text+0x12674): In function `bttv_remove':
: undefined reference to `i2c_bit_del_bus'
drivers/media/media.o(.text+0x12674): In function `bttv_remove':
: relocation truncated to fit: R_PPC_REL24 i2c_bit_del_bus
drivers/media/media.o(.text+0x13570): In function `init_bttv_i2c':
: undefined reference to `i2c_bit_add_bus'
drivers/media/media.o(.text+0x13570): In function `init_bttv_i2c':
: relocation truncated to fit: R_PPC_REL24 i2c_bit_add_bus
make: *** [vmlinux] Error 1


Any ideas on a fix?


Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
