From: wolfgang.grandegger@bluewin.ch
Date: Tue, 11 Feb 2003 09:45:51 +0100
Message-ID: <3E34EB7F00023064@mss3n.bluewin.ch>
In-Reply-To: <200302101644.53246.samble@xopnetworks.com>
Subject: RE: Kernel boot
To: samble@xopnetworks.com,
	"Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>-- Original Message --
>From: Srini Amble <samble@xopnetworks.com>
>Reply-To: samble@xopnetworks.com
>To: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
>Subject: Kernel boot
>Date: Mon, 10 Feb 2003 16:44:53 -0600
>
>
>
>I am using ELDK-2.0 to create a bootable kernel image for PPC8xx. I have
>PPCBoot on my target and I want to download the kernel from the host to
the
>target using TFTP boot. I have verified that I can transfer the image via
>TFTP boot. I am creating the initrd image using the following sequence of
>commands.
>
>1. make config
>2. make dep
>3. make clean
>4. make zImage.initrd
>5. Compress the "zvmlinux.initrd" executable using "gzip"
>6. Execute mkimage command to prepare it for "ppcboot"
>
>After the image is downloaded the kernel image is uncompressed without any
>errors. But then I get the messsage "No initrd" and the system no longer
>responds. Can one of you please point to where I may be going wrong?

For PPCBoot you normally build a pImage with:

 make pImage

and building a RAMDisk image is done differently as well. Have a
look to chapter 5 and 6 of the DENX PPCBoot and Linux Guide at http://www.denx.de/doc/TQM8xxL/.
The ELDK 2.0 comes already with
a working pRamdisk image provided by the RPM package SELF.It can
be found in "ppc_8xx/images". You need the SRPM if you want to
modify it. Also check ftp://ftp.denx.de/pub/LinuxPPC/usr/src/SELF/.

Hope it helps,

Wolfgang.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
