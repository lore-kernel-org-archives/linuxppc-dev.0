Return-Path: <lombardo@mdivac.com>
Received: from mail.mdivac.com (adsl-68-253-104-89.dsl.bcvloh.ameritech.net
	[68.253.104.89]) by ozlabs.org (Postfix) with ESMTP id 0434967BD5
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Nov 2006 10:49:21 +1100 (EST)
Message-ID: <4547DE29.6090708@mdivac.com>
Date: Tue, 31 Oct 2006 18:37:13 -0500
From: Frank D Lombardo <lombardo@mdivac.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: How do you debug the kernel on an ML403?
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

I am using a Xilinx ML403 board with the Parallel IV JTAG cable.  I have 
been able to use XMD and the Insight front end for GDB to debug both 
U-Boot and the uncompressed portion of the zImage.elf file.  However, I 
cannot set breakpoints in kernel code.  Can XMD  and the Parallel IV 
JTAG cable be used to debug kernel code?  How do you do that?

Thanks,
Frank
