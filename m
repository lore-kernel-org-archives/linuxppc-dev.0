Return-Path: <rongkai.zhan@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id E009567A42
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jun 2006 06:54:35 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Linux ppc port problem
Date: Wed, 21 Jun 2006 18:27:13 +0200
Message-ID: <6A3254532ACD7A42805B4E1BFD18080E01039494@ism-mail01.corp.ad.wrs.com>
From: "Zhan, Rongkai" <rongkai.zhan@windriver.com>
To: "robinpv" <robinpv@aiware.co.jp>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

You even have not a working kernel console.

Best Regards,
Mark. Zhan
-----Original Message-----
From: linuxppc-dev-bounces+rongkai.zhan=3Dwindriver.com@ozlabs.org =
[mailto:linuxppc-dev-bounces+rongkai.zhan=3Dwindriver.com@ozlabs.org] On =
Behalf Of robinpv
Sent: Wednesday, June 21, 2006 5:45 PM
To: linuxppc-dev@ozlabs.org
Subject: Linux ppc port problem

Hi ,
     I am trying to the port linux to the mpc5200 based board( =
Lite5200.)
     I am using linux version 2.6.16.1.  I am getting the below message=20
after that, linux seems to he in hanged state
     I debugged and found that the control is reaching the schedule() in =

rest_init() which is the last function called in start_kernel().
     I have set the command line arguements to "console=3DttyPSC0,115200 =

root=3D/dev/ram0 rw ramdisk_size=3D16384"
     Can you suggest, how to proceed or what could be the problem.

With regards
Robin


## Booting image at ff000000 ...
   Image Name:   Linux-2.6.16.1
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1301999 Bytes =3D  1.2 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at ff200000 ...
   Image Name:   ramdisk
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    2788700 Bytes =3D  2.7 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 03d05000, end 03fadd5c ... OK
id mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:setio
MMU:exit
setup_arch: enter
setup_arch: bootmem
arch: exit

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
