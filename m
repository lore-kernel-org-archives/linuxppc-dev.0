Message-Id: <200104060124.KAA08060@itl.nyc.co.jp>
Date: Fri, 6 Apr 2001 10:24:16 +0900
From: Masahide Tomita <tomita@itl.nyc.co.jp>
To: linuxppc-embedded@lists.linuxppc.org
Subject: What init in initrd shold do when booting?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm trying to boot Hard Hat Linux on MBX860, and it seems like just kernel worked successfully. But I can't mount any other partition, like hda or sda etc., because (I think) there is no /etc/mtab.
I'm using zImage.initrd made by zvmlinux (kernel) from HHL and sample ramdisk.image.gz in HHL's CDK cdrom combined. And the ramdisk.image.gz contains only few features because of the limitation of ramdisk size (4MB). I can, of course, increase the size of ramdisk, but I would like to mount bigger space for future applications.

So, the real quation is how can I mount regular storage (I mean block devices) from init? What should the init program should do to maount other devices and free the unused memory?

Thanks in advance.

Masahide Tomita

--
Masahide Tomita
Engineer
Information Technology Lab.
NAKAYO Telecommunications, INC.
PHONE:+81-3-3414-3321
mailto:tomita@itl.nyc.co.jp


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
