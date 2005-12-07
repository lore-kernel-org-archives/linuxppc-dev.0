Return-Path: <batsayan.das@tcs.com>
Received: from INKOLG01.tcs.com (inkolg01.tcs.com [203.197.96.54])
	by ozlabs.org (Postfix) with ESMTP id 9E88368872
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Dec 2005 22:54:30 +1100 (EST)
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
From: batsayan.das@tcs.com
Message-ID: <OFCBD37606.7E278616-ON652570D0.0028C041-652570D0.00360A00@tcs.com>
Date: Wed, 7 Dec 2005 15:20:25 +0530
Content-Type: multipart/alternative;
	boundary="=_alternative 00360987652570D0_="
Subject: Help required on mpc8260 kernel boot
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
--=_alternative 00360987652570D0_=
Content-Type: text/plain; charset="US-ASCII"


Hello,

I am using customs board with MPC8260 processor. I have RAM version of 
U-Boot and I am able to get U-Boot prompt when I load and run u-bbot.srec 
by TRACE32. My memory map is as follows

SDRAM start address :0x30000000  and 128MB
Flash start address: 0x00000000    and 1MB

I copied the kernel image at 0x30000000 by kermit. The load address and 
the entry point of the UImage is set at 0x34000000 and 0x34000000. At 
U-boot prompt when I run "bootm 0x30000000" . The kernel hangs with the 
message " Uncompressing Kernel Image..OK" 

My questions are

1. Is the above memory configuration is correct to run kernel from RAM 
U-boot?
2. The U-Boot documentation says that SDRAM should be at 0.  Does the 
kernel will run if SDRAM is not set to 0?
3. How can I debug where in kernel source tree it got hanged? 


Any pointer will be helpful. Thanks in advance.

Regards,
Batsayan Das
Tata Consultancy Services Limited
Mailto: batsayan.das@tcs.com
Website: http://www.tcs.com

Notice: The information contained in this e-mail message and/or attachments to it may contain confidential or privileged information.   If you are not the intended recipient, any dissemination, use, review, distribution, printing or copying of the information contained in this e-mail message and/or attachments to it are strictly prohibited.   If you have received this communication in error, please notify us by reply e-mail or telephone and immediately and permanently delete the message and any attachments.  Thank you
--=_alternative 00360987652570D0_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hello,</font>
<br>
<br><font size=2 face="sans-serif">I am using customs board with MPC8260
processor. I have RAM version of U-Boot and I am able to get U-Boot prompt
when I load and run u-bbot.srec by TRACE32. My memory map is as follows</font>
<br>
<br><font size=2 face="sans-serif">SDRAM start address :0x30000000 &nbsp;and
128MB</font>
<br><font size=2 face="sans-serif">Flash start address: 0x00000000 &nbsp;
&nbsp;and 1MB</font>
<br>
<br><font size=2 face="sans-serif">I copied the kernel image at 0x30000000
by kermit. The load address and the entry point of the UImage is set at
0x34000000 and 0x34000000. At U-boot prompt when I run &quot;bootm 0x30000000&quot;
. The kernel hangs with the message &quot; Uncompressing Kernel Image..OK&quot;
</font>
<br>
<br><font size=2 face="sans-serif">My questions are</font>
<br>
<br><font size=2 face="sans-serif">1. Is the above memory configuration
is correct to run kernel from RAM U-boot?</font>
<br><font size=2 face="sans-serif">2. The U-Boot documentation says that
SDRAM should be at 0. &nbsp;Does the kernel will run if SDRAM is not set
to 0?</font>
<br><font size=2 face="sans-serif">3. How can I debug where in kernel source
tree it got hanged? </font>
<br>
<br>
<br><font size=2 face="sans-serif">Any pointer will be helpful. Thanks
in advance.</font>
<br>
<br><font size=2 face="sans-serif">Regards,<br>
Batsayan Das<br>
Tata Consultancy Services Limited<br>
Mailto: batsayan.das@tcs.com<br>
Website: http://www.tcs.com</font>
<table><tr><td bgcolor=#ffffff><font color=#000000>Notice: The information contained in this e-mail message and/or attachments to it may contain confidential or privileged information.   If you are not the intended recipient, any dissemination, use, review, distribution, printing or copying of the information contained in this e-mail message and/or attachments to it are strictly prohibited.   If you have received this communication in error, please notify us by reply e-mail or telephone and immediately and permanently delete the message and any attachments.  Thank you<br>
</font></td></tr></table>
--=_alternative 00360987652570D0_=--
