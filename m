Return-Path: <robinpv@aiware.co.jp>
Received: from cat.aiware.co.jp (ml.aiware.jp [222.228.111.22])
	by ozlabs.org (Postfix) with ESMTP id 5BA1767A62
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jun 2006 20:15:31 +1000 (EST)
Received: from [192.168.25.80] (neko.aiware.jp [222.228.111.24])
	by cat.aiware.co.jp (Postfix) with ESMTP id E8A4CF4847
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jun 2006 18:44:29 +0900 (JST)
Message-ID: <4499152D.2040908@aiware.co.jp>
Date: Wed, 21 Jun 2006 18:45:17 +0900
From: robinpv <robinpv@aiware.co.jp>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Linux ppc port problem
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi ,
     I am trying to the port linux to the mpc5200 based board( Lite5200.)
     I am using linux version 2.6.16.1.  I am getting the below message 
after that, linux seems to he in hanged state
     I debugged and found that the control is reaching the schedule() in 
rest_init() which is the last function called in start_kernel().
     I have set the command line arguements to "console=ttyPSC0,115200 
root=/dev/ram0 rw ramdisk_size=16384"
     Can you suggest, how to proceed or what could be the problem.

With regards
Robin


## Booting image at ff000000 ...
   Image Name:   Linux-2.6.16.1
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1301999 Bytes =  1.2 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at ff200000 ...
   Image Name:   ramdisk
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    2788700 Bytes =  2.7 MB
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
