Return-Path: <Atit_Shah@satyam.com>
Received: from njpmail.satyam.com (njpmail.satyam.com [204.179.188.132])
	by ozlabs.org (Postfix) with ESMTP id 55E5C67A67
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Apr 2005 14:25:32 +1000 (EST)
Received: from blr.satyam.com (blr.satyam.com [208.220.245.73])
	by njpmail.satyam.com (8.11.6/8.11.6) with ESMTP id j3L4HAI00314
	for <linuxppc-embedded@ozlabs.org>; Thu, 21 Apr 2005 00:17:35 -0400
Received: from Disclaimerbng.corp.satyam.ad
	(IDENT:HF7kmXmF2RYIoLPb0gCkNdn7yQbnvD5Q@localhost [127.0.0.1])
	by blr.satyam.com (8.11.6/8.11.6) with ESMTP id j3L4JqA02689
	for <linuxppc-embedded@ozlabs.org>; Thu, 21 Apr 2005 09:49:53 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 21 Apr 2005 09:54:05 +0530
Message-ID: <D8595042F3765A4285B848A78A2C2ED1027750@bsdmsg002.corp.satyam.ad>
From: "Atit_Shah" <Atit_Shah@satyam.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Linux booting problem when initializing flash file system
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,

	I am using a board which has a ST Micro Electronics Flash
(M29W640DB) and when booting the Linux Kernel I get the following error:

jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000000:
0x0020 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000004:
0x22df instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0000000c:
0x0008 instead

Further such events for this erase block will not be printed
JFFS2: Erase block at 0x00000000 is not formatted. It will be erased
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00020000:
0x0020 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00020004:
0x22df instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0002000c:
0x0008 instead

And it ends with................

Cowardly refusing to erase blocks on filesystem with no valid JFFS2
nodes
Kernel panic: VFS: Unable to mount root fs on 1f:00
<0>Rebooting in 180 seconds..

The reference board using an AMD flash works fine. I selected the ST
Flash from make xconfig in Linux but the kernel crashes before it even
calls start_kernel.
Could somebody suggest wrong....

Thanks
Atit




DISCLAIMER:
This email (including any attachments) is intended for the sole use of =
the intended recipient/s and may contain material that is CONFIDENTIAL =
AND PRIVATE COMPANY INFORMATION. Any review or reliance by others or =
copying or distribution or forwarding of any or all of the contents in =
this message is STRICTLY PROHIBITED. If you are not the intended =
recipient, please contact the sender by email and delete all copies; =
your cooperation in this regard is appreciated.
