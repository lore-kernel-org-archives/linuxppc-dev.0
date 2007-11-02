Return-Path: <guojin02@tsinghua.org.cn>
Received: from tsinghua.org.cn (mail.tsinghua.org.cn [210.77.143.232])
	by ozlabs.org (Postfix) with SMTP id 69539DDDFD
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Nov 2007 14:26:18 +1100 (EST)
Message-ID: <393972917.10298@tsinghua.org.cn>
From: "=?gb2312?B?ufm+og==?=" <guojin02@tsinghua.org.cn>
To: linuxppc-embedded@ozlabs.org
Date: Fri, 02 Nov 2007 11:08:37 +0800
Subject: The question about the fail at the begin of linux on MPC8360E.
Content-Type: text/plain
Reply-To: =?gb2312?B?ufm+og==?= <guojin02@tsinghua.org.cn>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,friends,
Thanks.

We boot the linux-2.6.22 on MPC8360 board, it failed, follow is the output
information. we just only success on linux-2.6.11, but fail on linux-2.6.19 and
linux-2.6.22. Both 2.6.19 and 2.6.22 are failed on same position,please see follow
information. linux-2.6.19 and linux-2.6.22 are come from BSP of freescale. I used
the u-boot-1.2.0 that compiled by myself. We guess that maybe we did not setup the
bootargs parameter on u-boot rightly or maybe the DDR-I hardware circuit design is
not good enough.

If the reason is the bootargs parameter, could you tell me what is the right
bootargs for linux-2.6.19 and linux-2.6.22?

If the reason is the DDR, I want to boot the linux on my SDRAM chip,kick off the
DDR, my SDRAM located on the address of F0000000~F3FFFFFF, total 64MB. How can I
modify the source code of linux to re-map it and ramdisk and others to my SDRAM
chip space?


Follow is the fail information:
=> bootm 0c000000 0e000000
## Booting image at 0c000000 ...
   Image Name:   Linux-2.6.22
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1333681 Bytes =  1.3 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at 0e000000 ...
   Image Name:   uboot ext2 ramdisk rootfs
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    3589813 Bytes =  3.4 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 0fc3e000, end 0ffaa6b5 ... OK    
