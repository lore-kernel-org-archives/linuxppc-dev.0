Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Thu, 6 Sep 2001 01:42:38 -0700 (PDT)
From: James F Dougherty <jfd@GigabitNetworks.COM>
Message-Id: <200109060842.BAA12475@krakatoa.gigabitnetworks.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: FLASH RamDisk and kernel init options for disk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

What are peoples thoughts on the best way to make
a small ramdisk which fits in less than 1M and
performs the task of checking for a root disk,
running fsck, and then remounting it as root.

As a fallout condition, it would let your run
fdisk and possibly some network script which
runs rpm over the net..

The reason I ask is because I boot my kernel and
ramdisk from flash and would like to create a small
initrd that allows you to setup a system/disk if
it is not found.

Surely someone has done this ...

Also, is there some way to pass a kernel argument which
does an fsck on a disk before it mounts it every time?
I'm pretty sure this doesn't exist ..


			Thanks,
			-James

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
