Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
From: Brian Waite <waite@skycomputers.com>
To: Linux PPC <linuxppc-dev@lists.linuxppc.org>
Subject: pImage target gone
Date: Tue, 5 Aug 2003 17:48:29 -0400
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200308051748.29796.waite@skycomputers.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Hi all,
	I recently pulled the head and I found that we have lost the pImage
BOOT_TARGET. With some quick searching I found Paulus removed back on April
18, 2003. The comment notes the changes were for the removal of ppc32 iSeries
support. Now, I have boards that use the pImage target. I was wondering if,
since it is removed now, maybe we should reincoporate it as uImage to reflect
the new name of u-boot. Is there another reason why this might have been
removed? Just curious. Otherwise I'll supply a patch.

Thanks
Brian


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
