Return-Path: <junita@gdatech.com>
Received: from darwaza.gdatech.com (darwaza.gdatech.com [66.237.41.98])
	by ozlabs.org (Postfix) with ESMTP id 4FF9B67BD3
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Aug 2006 10:20:01 +1000 (EST)
Received: from [192.168.200.117] (localhost.localdomain [127.0.0.1])
	by kings.gdatech.com (Postfix-out) with ESMTP id 0ADB78BC0D6
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 14 Aug 2006 16:47:15 -0700 (PDT)
Received: from sierra.gdatech.com (sierra.gdatech.com [192.168.200.112])
	by kings.gdatech.com (Postfix-out) with ESMTP id D14F78BC0D3
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 14 Aug 2006 16:47:14 -0700 (PDT)
Date: Mon, 14 Aug 2006 16:47:44 -0700
Message-Id: <200608142347.k7ENliA24769@sierra.gdatech.com>
From: "Junita " <junita@gdatech.com>
To: linuxppc-embedded@ozlabs.org
Subject: Kernel boot-up issue after enabling FCC in MPC8560
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hello all,

I'm currently bringing up the FCC port in our MPC8560 based custom board
which has one TSEC port and another FCC port. We use u-boot-1.1.4 as
bootloader, where we have enabled FCC3 also.

When I downlaod the kernel and filesystem images through FCC system
boots-up to the prompt.
Sametime , while I download the through TSEC port, kernel hangs at a
strange point i.e before "Freeing the initrd memory".


Any help would be greatly appreciated.


Please find the screen-dump below.



Thanks,
Junita

########################################################################
In:    serial
Out:   serial
Err:   serial
Net:   TSEC0, FCC3 ETHERNET
Hit any key to stop autoboot:  0
RMCG8700_8560=> tftp 2000000 mpc8560/fcc/uImage
Speed: 1000, full duplex
Using TSEC0 device
TFTP from server 192.168.201.11; our IP address is 192.168.201.191
Filename 'mpc8560/fcc/uImage'.
Load address: 0x2000000
Loading: #################################################################
         #################################################################
         #################################################################
         #
done
Bytes transferred = 998700 (f3d2c hex)
RMCG8700_8560=> tftp 3000000 mpc8560/fcc/ramdisk.gz
Speed: 1000, full duplex
Using TSEC0 device
TFTP from server 192.168.201.11; our IP address is 192.168.201.191
Filename 'mpc8560/fcc/ramdisk.gz'.
Load address: 0x3000000
Loading: #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         ######################################################
done
Bytes transferred = 1935938 (1d8a42 hex)
RMCG8700_8560=> bootm 2000000 3000000
## Booting image at 02000000 ...
   Image Name:   Linux-2.6.14
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    998636 Bytes = 975.2 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at 03000000 ...
   Image Name:   GDA MPC8560
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    1935874 Bytes =  1.8 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 0fdc4000, end 0ff9ca02 ... OK
Memory CAM mapping: CAM0=256Mb, CAM1=0Mb, CAM2=0Mb residual: 0Mb
Linux version 2.6.14 (root@crater.gdatech.com) (gcc version 3.3.3 (DENX
ELDK 3.6Built 1 zonelists
Kernel command line:
OpenPIC Version 1.2 (1 CPUs and 60 IRQ sources) at fcf7d000
PID hash table entries: 2048 (order: 11, 32768 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 255360k available (1740k kernel code, 448k data, 116k init, 0k
highmem)
Mount-cache hash table entries: 512
checking if image is initramfs...it isn't (no cpio magic); looks like an
initrd
 



=====
This message contains information from GDA Technologies Inc and
affiliates, and is intended for the sole use of the individual and
entity to whom it is addressed. It may contain information, including
any attachments, that is privileged, confidential and exempt from
disclosure under applicable law. If you are not the intended addressee,
nor authorized to receive for the intended addressee, you are hereby
notified that you may not use, copy, disclose or distribute to anyone
the message or any information contained in the message. If you have
received this electronic transmission in error, please notify the sender
immediately by a "reply to sender only" message and destroy all
electronic and hard copies of the communication, including attachments.
====
