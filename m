Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 92B3CDDF78
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jan 2008 10:10:48 +1100 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.63)
	(envelope-from <jdl@jdl.com>) id 1JDT1Q-0007Bj-1Q
	for linuxppc-dev@ozlabs.org; Fri, 11 Jan 2008 17:10:45 -0600
To: linuxppc-dev@ozlabs.org
Subject: StorCenter Help?
Date: Fri, 11 Jan 2008 17:10:44 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1JDT1Q-0007Bj-1Q@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Folks,

Anyone out there with an 8241 board such as
the IoMega StorCenter who would be willing to
help me debug my arch/powerpc cuImage problems?

I feel like I am missing something very basic in
my port... like, "Did you map this memory right?"
or "Did you set _this_ magic bit?"

I have posted the 3 patches that provide the basic
port and cuImage support as well.  The U-Boot that
I have is still legacy, so I'd like to get linux
working first via the cuImage, and then work on U-Boot.

The problem is that as soon as U-Boot uncompresses the
cuImage and loads it, I get no further console output.

The failing log follows.

And I don't have a BDI-2000 or JTAG thing I can use here.
Which is sort of why I'm tossing this out for general help.

Thanks,
jdl



CPU:   MPC8241 Revision 1.4 at 199.999 MHz: 16 kB I-Cache 16 kB D-Cache
Board: StorCenter
PICR1 is now 00141b98
PICR2 is now 00040605
AMBOR is now c1
DRAM:  64 MB
FLASH:  8 MB
In:    serial
Out:   serial
Err:   serial
Net:   PCI device RTL8169#0: unknown chip version, assuming RTL-8169
PCI device: TxConfig = 0x0
RTL8169#0
Hit any key to stop autoboot:  0 
IOMEGA=> 
IOMEGA=> 
IOMEGA=> 
IOMEGA=> 
IOMEGA=> setenv serverip 192.168.0.10
IOMEGA=> setenv ipaddr 192.168.0.25
IOMEGA=> tftp 100000 cuImage.824x
TFTP from server 192.168.0.10; our IP address is 192.168.0.25
Filename 'cuImage.824x'.
Load address: 0x100000
Loading: #################################################################
         #################################################################
         #################################################################
         #################################################################
         ##
done
Bytes transferred = 1337749 (146995 hex)
IOMEGA=> bootm 100000
## Booting image at 00100000 ...
   Image Name:   Linux-2.6.24-rc6-g550234b0-dirty
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1337685 Bytes =  1.3 MB
   Load Address: 00400000
   Entry Point:  00400544
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
   Loading kernel ......
