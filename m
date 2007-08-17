Return-Path: <jonsmirl@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.190])
	by ozlabs.org (Postfix) with ESMTP id 0A0F6DDDF8
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 18 Aug 2007 05:47:08 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so670187rvf
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Aug 2007 12:47:07 -0700 (PDT)
Message-ID: <9e4733910708171247n15475e4l2c86cade776d3fb3@mail.gmail.com>
Date: Fri, 17 Aug 2007 15:47:06 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Booting new MPC5200B board
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm using OSELAS-tiny-5 to compile a kernel for my new Phytec
5200B-tiny board with u-boot. When I try booting the kernel via tftpd
I get this error about the RAMDisk. Why does it want a RAMDisk, and
how do I supply it with one?

uboot> run bcmd_net
Using FEC ETHERNET device
TFTP from server 192.168.1.4; our IP address is 192.168.1.11
Filename 'uImage-pcm030'.
Load address: 0x500000
Loading: #################################################################
         #################################################################
         #################################################################
         ###########################################
done
Bytes transferred = 1215281 (128b31 hex)
Using FEC ETHERNET device
TFTP from server 192.168.1.4; our IP address is 192.168.1.11
Filename 'oftree-pcm030.dtb'.
Load address: 0x400000
Loading: #
done
Bytes transferred = 5091 (13e3 hex)
## Booting image at 00500000 ...
   Image Name:   Linux-2.6.20-rt3-pcm030-4
   Created:      2007-08-17  19:20:07 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1215217 Bytes =  1.2 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at 00000000 ...
Bad Magic Number


-- 
Jon Smirl
jonsmirl@gmail.com
