Return-Path: <ndroogh@rogers.com>
Received: from smtp108.rog.mail.re2.yahoo.com (smtp108.rog.mail.re2.yahoo.com
	[68.142.225.206]) by ozlabs.org (Postfix) with SMTP id CAB49DDE20
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Sep 2007 02:58:21 +1000 (EST)
Message-ID: <46FD311D.2050100@rogers.com>
Date: Fri, 28 Sep 2007 12:51:41 -0400
From: Nick <ndroogh@rogers.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Help with Device tree setup and booting kernel
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

I am having trouble booting a 2.6.23-rc6 kernel with a device tree.  My 
board is a MPC5200b base board with 128 Megs of DDR memeory.
My UBoot (1.3.0-rc2)seems to be doing what is should be doing.  I 
download the .dtb file to 00800000 and the uImage to 00200000
I get the following:

=> bootm 00200000 - 00800000
## Booting image at 00200000 ...
  Image Name:   Linux-2.6.23-rc6-gea60adb5-dirty
  Created:      2007-09-28   9:49:16 UTC
  Image Type:   PowerPC Linux Kernel Image (gzip compressed)
  Data Size:    1212342 Bytes =  1.2 MB
  Load Address: 00000000
  Entry Point:  00000000
  Verifying Checksum ... OK
  Uncompressing Kernel Image ... OK
  Booting using the fdt at 0x800000
  Loading Device Tree to 007fc000, end 007fefff ... OK

My board is now hung, with no more output to the console.  My board does 
work.  I have been running 2.6.19 for more than a year but I had to 
upgrade.

I used the latest kernel code from DENX.  Is this a good distribution or 
is there a better one somewhere else?  I can send my dts file and the 
kernel .config file if anyone is willing to help

Thanks in advance,

Nick
