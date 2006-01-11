Return-Path: <happa@wmlab.csie.ncu.edu.tw>
Received: from wmlab.csie.ncu.edu.tw (wmlab.csie.ncu.edu.tw [140.115.155.134])
	by ozlabs.org (Postfix) with ESMTP id 0762868A29
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jan 2006 21:26:22 +1100 (EST)
Received: from 140.115.155.134 (localhost.csie.ncu.edu.tw [127.0.0.1])
	by wmlab.csie.ncu.edu.tw (Postfix) with SMTP id 0F9251100F2
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jan 2006 18:26:18 +0800 (CST)
From: happa@wmlab.csie.ncu.edu.tw
To: linuxppc-embedded@ozlabs.org
Date: Wed, 11 Jan 2006 18:26:18 +0800(CST)
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="--43C4DD4A0000CBBE@wmlab.csie.ncu.edu.tw"
Message-Id: <20060111102618.0F9251100F2@wmlab.csie.ncu.edu.tw>
Subject: About MMU setting in MPC8245
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

----43C4DD4A0000CBBE@wmlab.csie.ncu.edu.tw
Content-Type: text/plain; Charset=Big5;
Content-Transfer-Encoding: 8bit

Hi,
Sorry, I have very basic question about PPC MMU setting.

In "http://www.denx.de/wiki/PPCEmbedded/Kernel#BOOTLOADER",
chapter 10.2. Memory Map, I get the following information.
 
"The bootloader is responsible for configuring the memory map before jumping to the Linux kernel."

Is anyone know what memory map should be done in bootloader? 
If I'm using ICE to load linux kernel, what kind of CPU registers need be configured first?
Is IBAT/DBAT and Segment register need be set?

I have set the following registers before loading kernel via ICE.
Did I miss something else?
(The target CPU is MPC8245)
offset   register 
-------  -----------------------------------
0x0C     Cache Line Size 
0x04     PCI Command Register 
0xA8     Processor interface configuration 1     
0xAC     Processor interface configuration 2  
0x80     Memory starting address register1
0x84     Memory starting address register2
0x88     Extended memory starting addressregister1
0x8C     Extended memory starting addressregister2
0x90     Memory ending address register1
0x94     Memory ending address register2
0x98     Extended memory ending address register1
0x9C     Extended memory ending address register2
0xA0     Memory bank enable register
0xD0     Extended ROM configuration register 1
0xD4     Extended ROM configuration register 2
0xD8     Extended ROM configuration register 3
0xDC     Extended ROM configuration register 4
0xF0     MCCR1
0xF4     MCCR2
0xF8     MCCR3
0xFC     MCCR4

Would anyone give me some references about MMU setting? 
----43C4DD4A0000CBBE@wmlab.csie.ncu.edu.tw--
