Return-Path: <will.kritikos@gmail.com>
Received: from ik-out-1112.google.com (ik-out-1112.google.com [66.249.90.177])
	by ozlabs.org (Postfix) with ESMTP id 51136DDE2A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 May 2008 02:03:28 +1000 (EST)
Received: by ik-out-1112.google.com with SMTP id c21so795841ika.1
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 May 2008 09:03:26 -0700 (PDT)
Message-ID: <3ee6f9e50805140903o381346f5kddbce29a3d06ba1f@mail.gmail.com>
Date: Wed, 14 May 2008 12:03:25 -0400
From: "Will Kritikos" <will.kritikos@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: xilinx_hwicap driver problems
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am having some trouble using the xilinx_hwicap driver in Linux.
I am using version 2.6.24-rc8-xlnx of the Linux kernel from the Xilinx
GIT repository.
The xilinx_hwicap driver is statically compiled in - not a loadable module.
I am using the opb_hwicap device on a V4FX60 FPGA, Linux running on the PPC405.

The driver successfully is initialized on boot - I added a printk to
the init function to verify this.   However, as far as I can tell, the
probe function is never called.  There is nothing in dmesg from the
icap driver.

After boot, the following files exist in /sys

/sys/bus/platform/xilinx_icap.0
/sys/bus/platform/drivers/icap/bind
/sys/bus/platform/drivers/icap/uevent
/sys/bus/platform/drivers/icap/unbind
/sys/devices/platform/xilinx_icap.0

I can make a device node /dev/icap, major number 259 minor number 0,
and copy partial bitstreams to it, but again nothing happens, and no
output in dmesg.

Any help is appreciated.  I am probably overlooking something simple.

Thanks,
Will Kritikos
