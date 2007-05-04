Return-Path: <richard.danter@ntlworld.com>
Received: from queue03-winn.ispmail.ntl.com (queue03-winn.ispmail.ntl.com
	[81.103.221.57]) by ozlabs.org (Postfix) with ESMTP id 925A0DDF63
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 May 2007 22:58:11 +1000 (EST)
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])
	by mtaout03-winn.ispmail.ntl.com with ESMTP id
	<20070504123229.JPZ16175.mtaout03-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>
	for <linuxppc-embedded@ozlabs.org>; Fri, 4 May 2007 13:32:29 +0100
Received: from dhcp-1-205 ([82.18.130.18])
	by aamtaout02-winn.ispmail.ntl.com with ESMTP id
	<20070504123229.DNWO17393.aamtaout02-winn.ispmail.ntl.com@dhcp-1-205>
	for <linuxppc-embedded@ozlabs.org>; Fri, 4 May 2007 13:32:29 +0100
From: Richard Danter <richard.danter@ntlworld.com>
To: linuxppc-embedded@ozlabs.org
Subject: initramfs on PowerPC
Date: Fri, 4 May 2007 13:32:26 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200705041332.27296.richard.danter@ntlworld.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I am having a problem booting a kernel with an initramfs. The kernel version 
is 2.6.14. The target is a ppc 82xx board.

I have tried both generating the cpio.gz file myself (find . | copi -o -H 
newc | gzip > ../initramfs_data.cpio.gz) and pointing initramfs source to a 
root FS directory (using xconfig) and then re-building my kernel.

Usually the error is "junk in compressed archive" though I also see an 
occasional error about padding.

I am using U-Boot to load the kernel image (uImage).

My host is SuSE 10.0 (x86), though I guess that shouldn't make any difference 
(endianism?).

Any thoughts on what I may be doing wrong?

Thanks
Rich
