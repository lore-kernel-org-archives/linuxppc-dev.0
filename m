Message-Id: <5.1.1.6.2.20030620133837.0131da68@corelis.com>
Date: Fri, 20 Jun 2003 13:48:40 -0700
To: linuxppc-embedded@lists.linuxppc.org
From: "Brian S. Park" <brian@corelis.com>
Subject: kernel modules and symbols
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,
I got Linux running on our custom board and am in the process of learning
how to build the final image to be burned on the flash.

To support our application I wrote simple device driver which maps the
physical address space to user space.
During development (NFS file system), it worked good enough. I could
install/un-install it without any problem using insmod/rmmod.
However, when I tried to install the module when using SELF ramdisk image,
I get bunch of unresolved symbols error.

What gives? I'm using exactly the same kernel so the symbols should be
there whether I use NFS root or SELF ram disk as root.

Any help will be appreciated.

# insmod FPGA_module
Using /lib/modules/2.4.20/FPGA_module.o
insmod: unresolved symbol remap_page_range
insmod: unresolved symbol create_proc_entry
insmod: unresolved symbol ioremap
insmod: unresolved symbol iounmap
insmod: unresolved symbol proc_mkdir
insmod: unresolved symbol remove_proc_entry
insmod: unresolved symbol sprintf
insmod: unresolved symbol printk


===============================================================
Brian S. Park  brian@corelis.com  (562) 926-6727 x143
---------------------------------------------------------------
Everything we do helps our customers get to market
FASTER with HIGHER quality and LOWER cost
===============================================================


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
