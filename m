Return-Path: <tath76@yahoo.com>
Message-ID: <20050309130950.98765.qmail@web51405.mail.yahoo.com>
Date: Wed, 9 Mar 2005 05:09:50 -0800 (PST)
From: T T <tath76@yahoo.com>
To: Linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-702076565-1110373790=:95768"
Subject: port linux to custom board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-702076565-1110373790=:95768
Content-Type: text/plain; charset=us-ascii

Host computer: AMD ( I think K8 amd cpu which is i686)
target: custom board (XC2VP4 fpga that contains ppc405, and build around the ppc405 are peripherals UARTLITE, SPI controller, SDRAM controller, PLB (processor locus bus).  I have used serial SPI flash from ST(M25P32).  NO ETHERNET
 
GNU toolchain I build ==> binutils (2.10.1)  gcc (2.95.3), glibc (2.2.1) includes 2.2.1 linuxthread.
 
I have follow instructions from "Building Embedded Linux Systems" book to build the kernel image.  After I follow up to chapter to 5,  the follow instructions that I did are
 
   $make ARCH=ppc CROSS_COMPILE=powerpc-linux- clean dep
   $make ARCH=ppc CROSS_COMPILE=powerpc-linux- zImage
   $make ARCH=ppc CROSS_COMPILE=powerpc-linux- moudles
 
during step "installing the kernel" on page 167, I look under /arch/ppc/boot/zImage, and could not find the zImage.  <== don't know why, I had seen the other files like system.map, vmlinux .config.
 
other questions I want to ask is seen I have use serial spi flash memory (ST M25P32) ==> how do I build the "Root file system" on this flash, how do I do with the MTD, and bootloader.  I am new to this stuff, so I don't what to do.  
 
thanks.

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-702076565-1110373790=:95768
Content-Type: text/html; charset=us-ascii

<DIV>Host computer: AMD ( I think K8 amd cpu which is i686)</DIV>
<DIV>target: custom board (XC2VP4 fpga that contains ppc405, and build around the ppc405&nbsp;are&nbsp;peripherals UARTLITE, SPI controller, SDRAM controller, PLB (processor locus bus).&nbsp; I have used serial SPI flash from ST(M25P32).&nbsp; NO ETHERNET</DIV>
<DIV>&nbsp;</DIV>
<DIV>GNU toolchain I build ==&gt; binutils (2.10.1)&nbsp; gcc (2.95.3), glibc (2.2.1) includes 2.2.1 linuxthread.</DIV>
<DIV>&nbsp;</DIV>
<DIV>I have follow instructions from "Building Embedded Linux Systems" book to build the kernel image.&nbsp; After I follow up to chapter to 5,&nbsp; the follow instructions that I did are</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp; $make ARCH=ppc CROSS_COMPILE=powerpc-linux- clean dep</DIV>
<DIV>&nbsp;&nbsp; $make ARCH=ppc CROSS_COMPILE=powerpc-linux- zImage</DIV>
<DIV>&nbsp;&nbsp; $make ARCH=ppc CROSS_COMPILE=powerpc-linux- moudles</DIV>
<DIV>&nbsp;</DIV>
<DIV>during step "installing the kernel" on page 167, I look under /arch/ppc/boot/zImage, and could not find the zImage.&nbsp; &lt;== don't know why, I had seen the other files like system.map, vmlinux .config.</DIV>
<DIV>&nbsp;</DIV>
<DIV>other questions I want to ask is seen I have use serial spi flash memory (ST M25P32) ==&gt; how do I build the "Root file system" on this flash, how do I do with the MTD, and bootloader.&nbsp; I am new to this stuff, so I don't what to do.&nbsp; </DIV>
<DIV>&nbsp;</DIV>
<DIV>thanks.</DIV><p>__________________________________________________<br>Do You Yahoo!?<br>Tired of spam?  Yahoo! Mail has the best spam protection around <br>http://mail.yahoo.com 
--0-702076565-1110373790=:95768--
