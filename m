Message-ID: <39D485A1.2785C0E4@serialsystem.com.sg>
Date: Fri, 29 Sep 2000 19:05:53 +0700
From: Jari <jari.nguyen@smartstors.com>
Reply-To: jari.nguyen@smartstors.com
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: mount RAMDISK directly on rom
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

Is there anyone know how to let the uncompressed ramdisk image in the
rom,
and mount root system directly from it (read only)?

I think that I have to modify  mount_root() function,
reinitialize  super_block *sb directly by reading ramdisk image from the
rom,
before calling add_vsfmnt(sb,"/dev/root","/"),
is that right? of course, I have to build  a kernel image with
uncompress image,
modify the code which copy ramdisk image to ram_device.

If you have done it, and see my way is incorrect,
or know where to look for information about it, teach me please.

Thanks in advance,
Jari


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
