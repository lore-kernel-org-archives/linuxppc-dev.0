Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Content-Type: text/plain;
  charset="us-ascii"
From: Srini Amble <samble@xopnetworks.com>
Reply-To: samble@xopnetworks.com
To: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Kernel boot
Date: Mon, 10 Feb 2003 16:44:53 -0600
MIME-Version: 1.0
Message-Id: <200302101644.53246.samble@xopnetworks.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am using ELDK-2.0 to create a bootable kernel image for PPC8xx. I have
PPCBoot on my target and I want to download the kernel from the host to the
target using TFTP boot. I have verified that I can transfer the image via
TFTP boot. I am creating the initrd image using the following sequence of
commands.

1. make config
2. make dep
3. make clean
4. make zImage.initrd
5. Compress the "zvmlinux.initrd" executable using "gzip"
6. Execute mkimage command to prepare it for "ppcboot"

After the image is downloaded the kernel image is uncompressed without any
errors. But then I get the messsage "No initrd" and the system no longer
responds. Can one of you please point to where I may be going wrong?

Thanks in anticipation

Srini

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
