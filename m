Return-Path: <batsayan.das@tcs.com>
Received: from InMumG01.tcs.com (inmumg01.tcs.com [219.64.33.12])
	by ozlabs.org (Postfix) with ESMTP id AC8FA6884E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Dec 2005 16:06:26 +1100 (EST)
To: u-boot-users@lists.sourceforge.net
MIME-Version: 1.0
From: batsayan.das@tcs.com
Message-ID: <OFB8CF31AB.E132BC0B-ON652570D9.001789DD-652570D9.001A8A99@tcs.com>
Date: Fri, 16 Dec 2005 10:19:53 +0530
Content-Type: multipart/alternative;
	boundary="=_alternative 001A8A34652570D9_="
Cc: linuxppc-embedded@ozlabs.org
Subject: Help required to bring up kernel from U-Boot 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 001A8A34652570D9_=
Content-Type: text/plain; charset="US-ASCII"


Hello,

I am using MPC8260ADS based customs board. I have configured the memory 
map in U-Boot as follows

SDRAM : 0x00000000  (size=128 MB)
FLASH   :  0x30000000 (size= 1MB)
SRAM : 0xFFF00000 (size 4MB)

There are also other components in the board, like  FRAMER , DSP, etc. I 
have not initialized the memory map of those components in U-Boot. 
I am able to get the U-Boot prompt when run by TRACE23.  I have build a 
default MPC8260ADS kernel, the only changes I have made is in the variable 
IMAP_ADDR , BCSR_ADDR in  arch/ppc/platforms/ads8260.h. I have put those 
values from the already running U-Boot code. 

Our TEXT_BASE=0xFFF00000
HRCW value= "0E A2 82 05" 

I copied uImage to location 0x04000000 and  the Load Address=0x00000000 
and Entry point=0x00000000.  The bootm 0x04000000 gives the o/p 
"Transferring Control to Linux" and then nothing comes. Where is the 
wrong?

My question is
1. What are the minimum information Linux needs from U-Boot to come up 
properly?  In the Linux source tree we have put some printk statement and 
found that base address of SDRAM, size, etc are passed correctly to Linux 
by U-Boot. 
2. Is the info passed from U-Boot is sufficient enough to make the kernel 
up?
3. If not, where should I concentrate in Linux tree?

Pls help.

Thanks,
Batsayan Das
Tata Consultancy Services Limited
Mailto: batsayan.das@tcs.com
Website: http://www.tcs.com

Notice: The information contained in this e-mail message and/or attachments to it may contain confidential or privileged information.   If you are not the intended recipient, any dissemination, use, review, distribution, printing or copying of the information contained in this e-mail message and/or attachments to it are strictly prohibited.   If you have received this communication in error, please notify us by reply e-mail or telephone and immediately and permanently delete the message and any attachments.  Thank you
--=_alternative 001A8A34652570D9_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hello,</font>
<br>
<br><font size=2 face="sans-serif">I am using MPC8260ADS based customs
board. I have configured the memory map in U-Boot as follows</font>
<br>
<br><font size=2 face="sans-serif">SDRAM : 0x00000000 &nbsp;(size=128 MB)</font>
<br><font size=2 face="sans-serif">FLASH &nbsp; &nbsp; &nbsp; &nbsp;:
&nbsp;0x30000000 (size= 1MB)</font>
<br><font size=2 face="sans-serif">SRAM : 0xFFF00000 (size 4MB)</font>
<br>
<br><font size=2 face="sans-serif">There are also other components in the
board, like &nbsp;FRAMER , DSP, etc. I have not initialized the memory
map of those components in U-Boot. </font>
<br><font size=2 face="sans-serif">I am able to get the U-Boot prompt when
run by TRACE23. &nbsp;I have build a default MPC8260ADS kernel, the only
changes I have made is in the variable IMAP_ADDR , BCSR_ADDR in &nbsp;arch/ppc/platforms/ads8260.h.
I have put those values from the already running U-Boot code. </font>
<br>
<br><font size=2 face="sans-serif">Our TEXT_BASE=0xFFF00000</font>
<br><font size=2 face="sans-serif">HRCW value= &quot;0E A2 82 05&quot;
</font>
<br>
<br><font size=2 face="sans-serif">I copied uImage to location 0x04000000
and &nbsp;the Load Address=0x00000000 and Entry point=0x00000000. &nbsp;The
bootm 0x04000000 gives the o/p &quot;Transferring Control to Linux&quot;
and then nothing comes. Where is the wrong?</font>
<br><font size=2 face="sans-serif"><br>
My question is</font>
<br><font size=2 face="sans-serif">1. What are the minimum information
Linux needs from U-Boot to come up properly? &nbsp;In the Linux source
tree we have put some printk statement and found that base address of SDRAM,
size, etc are passed correctly to Linux by U-Boot. </font>
<br><font size=2 face="sans-serif">2. Is the info passed from U-Boot is
sufficient enough to make the kernel up?</font>
<br><font size=2 face="sans-serif">3. If not, where should I concentrate
in Linux tree?</font>
<br>
<br><font size=2 face="sans-serif">Pls help.</font>
<br>
<br><font size=2 face="sans-serif">Thanks,</font>
<br><font size=2 face="sans-serif">Batsayan Das<br>
Tata Consultancy Services Limited<br>
Mailto: batsayan.das@tcs.com<br>
Website: http://www.tcs.com</font>
<table><tr><td bgcolor=#ffffff><font color=#000000>Notice: The information contained in this e-mail message and/or attachments to it may contain confidential or privileged information.   If you are not the intended recipient, any dissemination, use, review, distribution, printing or copying of the information contained in this e-mail message and/or attachments to it are strictly prohibited.   If you have received this communication in error, please notify us by reply e-mail or telephone and immediately and permanently delete the message and any attachments.  Thank you<br>
</font></td></tr></table>
--=_alternative 001A8A34652570D9_=--
