Return-Path: <scott.coulter@cyclone.com>
Received: from CYBORG3.cyclone.com (unknown [69.37.28.78])
	by ozlabs.org (Postfix) with ESMTP id D5D0B67C2C
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 10 Jun 2006 05:32:49 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: booting Linux 2.6.15 using a ramdisk and greater than 512MB of DRAM
Date: Fri, 9 Jun 2006 15:28:50 -0400
Message-ID: <43EB80E07C42E1408726E4905FB96B0466C6C0@CYBORG3.cyclone.com>
From: "Scott Coulter" <scott.coulter@cyclone.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



Hi everyone,

I am not sure if this is a linux question or a u-boot question.  I have
a custom MPC8540 board running U-boot 1.1.4.  With a NFS root
configuration, I have booted and run 2.6.15 with memory from 256MB to
2GB.  If I build a ramdisk image (or even if I use the ramdisk image
with the 85xx version of ELDK 4.0) and then combine it with the kernel
image (vmlinux.gz) using "mkimage", the linux boot blows out with an
oops if I boot the board with more that 512MB of DRAM.  From the U-boot
output, it looks like the ramdisk image is getting copied to the upper
portion of DRAM.  Is it possible that the kernel doesn't map enough DRAM
to allow the image to be read?

I haven't spent a lot of time debugging this once I saw that the 512MB
configuration worked OK.  Has anyone run into this?

Thanks,

Scott



___________________________________________________________________

  Scott N. Coulter
  Senior Software Engineer
 =20
  Cyclone Microsystems         =20
  370 James Street              Phone:  203.786.5536 ext. 118
  New Haven, CT 06513-3051      Email:  scott.coulter@cyclone.com
  U.S.A.                        Web:    http://www.cyclone.com
___________________________________________________________________
