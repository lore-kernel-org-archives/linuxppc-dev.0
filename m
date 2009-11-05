Return-Path: <Frank.Prepelica@ubidyne.com>
Received: from mail.ubidyne.com (mail.ubidyne.com [212.211.133.238])
	by ozlabs.org (Postfix) with ESMTP id 04413B7B99
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Nov 2009 21:14:56 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: System hangs when exceeding a certain initramfs size
Date: Thu, 5 Nov 2009 11:02:46 +0100
Message-ID: <29DC34A6B43468409F5A371CFE34E849F9AFBA@ex01.ads.ubidyne.de>
From: "Frank Prepelica" <Frank.Prepelica@ubidyne.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

I experience the issue when the kernel image (including the initramfs)
exceeds a=20
certain size (>6MB) that after unpacking the kernel the systems hangs
at:

bootm 2000000 - 3000000
## Booting image at 02000000 ...
   Image Name:   Linux-2.6.29
   Created:      2009-11-04  14:25:01 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    6798037 Bytes =3D  6.5 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
   Booting using the fdt at 0x3000000
   Loading Device Tree to 00ffc000, end 00ffefff ... OK


I've found some hints regarding this problem (load_address in the
wrapper script)=20
but this doesn't works for me.=20

I'm using Kernel v2.6.29 and U-Boot v1.3.0 on a customized MPC8313ERDB
board

Thank you for any help!

Kind regards
Frank
