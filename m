Message-ID: <39E766CF.74B9C039@emc.com>
Date: Fri, 13 Oct 2000 15:47:27 -0400
From: Zhaobin Zhu <zzhu@emc.com>
MIME-Version: 1.0
CC: linuxppc-embedded@lists.linuxppc.org
Subject: <kernel-image-name>
References: <007201c0339d$5b235c60$0a00010a@airvent.it>
Content-Type: text/plain; charset=gb2312
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am setting up host (Redhat 6.2 i386) for sp7400 boot over NFS.

I do this following instructions on manual for Hardhat CDK 1.2

When configuring TFTP, to create a symbolic link to boot file
in /tftpboot,

ln -s /opt/hardhat/devkit/ppc/82xx/target/boot/<kernel-image-name>
<kernel-image-name>

What should I give to <kernel-image-name> ?

When I do "make zImage", I got two binaries, vmlinux and zvmlinux. I also
create a S-record file.
Which of the 3 files do I use as <kernel-image-name> ?

BTW, what is the role of tftp in kernel boot on NFS ?
I don't see any tftp message when kernel is booting ?

Thanks,

--
 Zhaobin Zhu
 zzhu@emc.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
