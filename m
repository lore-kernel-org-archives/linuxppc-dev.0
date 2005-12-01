Return-Path: <pritha.bhattacharya@tcs.com>
Received: from INKOLG01.tcs.com (inkolg01.tcs.com [203.197.96.54])
	by ozlabs.org (Postfix) with ESMTP id A8A6A6884B
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Dec 2005 22:31:36 +1100 (EST)
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
MIME-Version: 1.0
From: pritha.bhattacharya@tcs.com
Message-ID: <OF0098DF7F.857DE409-ON652570CA.001AA3F7-652570CA.0036DB32@tcs.com>
Date: Thu, 1 Dec 2005 15:29:10 +0530
Content-Type: multipart/alternative;
	boundary="=_alternative 0036D983652570CA_="
Subject: Linux hangs while Uncompressing
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
--=_alternative 0036D983652570CA_=
Content-Type: text/plain; charset="US-ASCII"


Hi All,

I have RAM version of U-Boot which is running on a board similar to 
MPC8260. My memory map isas follows:

Staring address         Device          Size                  Memory 
controller and CS

0000 0000
0800 0000
FFF0 0000
0F00 0000
3000 0000
3800 0000
4200 0000
5000 0000
FLASH (Boot)
FLASH (Code)
SSRAM
CPU internal registers
SDRAM
SDRAM
Framer
DSP 8102
1MB (512Kx16)
4 MB (1Mx16)
2 MB (512Kx36)
128 KB
128 MB (16Mx72)
128 MB (16Mx72)
1 MB
2 MB
BR0/OR0: CS0
BR1/OR1: CS1
BR2/OR2: CS2

BR3/OR3: CS3
BR4/OR4: CS4
BR5/OR5: CS5
BR6/OR6: CS6


I have downloaded Linux 2.4.25 kernel image through kermit. after 
downloading the image in SDRAM location 0x30000000 and giving the command 
bootm 0x30000000

 the prompt shows a message:


TCS-PIC-UBOOT=> loadb 0x30000000## Ready for binary (kermit) download to 
0x30000000 at 57600 bps...

## Total Size      = 0x000936f6 = 603894 Bytes
## Start Addr      = 0x30000000
TCS-PIC-UBOOT=> bootm 0x30000000## Booting image at 30000000 ...
   Image Name:   Linux-2.4.25
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    603830 Bytes = 589.7 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... 

The system hangs here and is not able to uncompress the kernel any 
further. I have checked in the FAQs provided in the denx's site, but could 
not find anything similar to my case.

I would appreciate any help.

Thanks & Regards,
Pritha Bhattacharya
Tata Consultancy Services Limited
Mailto: pritha.bhattacharya@tcs.com
Website: http://www.tcs.com

Notice: The information contained in this e-mail message and/or attachments to it may contain confidential or privileged information.   If you are not the intended recipient, any dissemination, use, review, distribution, printing or copying of the information contained in this e-mail message and/or attachments to it are strictly prohibited.   If you have received this communication in error, please notify us by reply e-mail or telephone and immediately and permanently delete the message and any attachments.  Thank you
--=_alternative 0036D983652570CA_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hi All,</font>
<br>
<br><font size=2 face="sans-serif">I have RAM version of U-Boot which is
running on a board similar to MPC8260. My memory map isas follows:</font>
<br>
<br><font size=2 face="sans-serif">Staring address &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Device &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Size &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;Memory controller and CS</font>
<br>
<table border>
<tr valign=top>
<td><font size=2 face="Times New Roman">0000 0000</font>
<br><font size=2 face="Times New Roman">0800 0000</font>
<br><font size=2 face="Times New Roman">FFF0 0000</font>
<br><font size=2 face="Times New Roman">0F00 0000</font>
<br><font size=2 face="Times New Roman">3000 0000</font>
<br><font size=2 face="Times New Roman">3800 0000</font>
<br><font size=2 face="Times New Roman">4200 0000</font>
<br><font size=2 face="Times New Roman">5000 0000</font>
<td><font size=2 face="Times New Roman">FLASH (Boot)</font>
<br><font size=2 face="Times New Roman">FLASH (Code)</font>
<br><font size=2 face="Times New Roman">SSRAM</font>
<br><font size=2 face="Times New Roman">CPU internal registers</font>
<br><font size=2 face="Times New Roman">SDRAM</font>
<br><font size=2 face="Times New Roman">SDRAM</font>
<br><font size=2 face="Times New Roman">Framer</font>
<br><font size=2 face="Times New Roman">DSP 8102</font>
<td><font size=2 face="Times New Roman">1MB (512Kx16)</font>
<br><font size=2 face="Times New Roman">4 MB (1Mx16)</font>
<br><font size=2 face="Times New Roman">2 MB (512Kx36)</font>
<br><font size=2 face="Times New Roman">128 KB</font>
<br><font size=2 face="Times New Roman">128 MB (16Mx72)</font>
<br><font size=2 face="Times New Roman">128 MB (16Mx72)</font>
<br><font size=2 face="Times New Roman">1 MB</font>
<br><font size=2 face="Times New Roman">2 MB</font>
<td><font size=2 face="Times New Roman">BR0/OR0: CS0</font>
<br><font size=2 face="Times New Roman">BR1/OR1: CS1</font>
<br><font size=2 face="Times New Roman">BR2/OR2: CS2</font>
<br>
<br><font size=2 face="Times New Roman">BR3/OR3: CS3</font>
<br><font size=2 face="Times New Roman">BR4/OR4: CS4</font>
<br><font size=2 face="Times New Roman">BR5/OR5: CS5</font>
<br><font size=2 face="Times New Roman">BR6/OR6: CS6</font></table>
<br>
<br>
<br><font size=2 face="sans-serif">I have downloaded Linux 2.4.25 kernel
image through kermit. after downloading the image in SDRAM location 0x30000000
and giving the command </font>
<br><font size=2 face="sans-serif"><i>bootm 0x30000000</i></font>
<br>
<br><font size=2 face="sans-serif">&nbsp;the prompt shows a message:</font>
<br>
<br>
<br><font size=2 face="sans-serif"><i>TCS-PIC-UBOOT=&gt; loadb 0x30000000##
Ready for binary (kermit) download to 0x30000000 at 57600 bps...</i></font>
<br>
<br><font size=2 face="sans-serif"><i>## Total Size &nbsp; &nbsp; &nbsp;=
0x000936f6 = 603894 Bytes</i></font>
<br><font size=2 face="sans-serif"><i>## Start Addr &nbsp; &nbsp; &nbsp;=
0x30000000</i></font>
<br><font size=2 face="sans-serif"><i>TCS-PIC-UBOOT=&gt; bootm 0x30000000##
Booting image at 30000000 ...</i></font>
<br><font size=2 face="sans-serif"><i>&nbsp; &nbsp;Image Name: &nbsp; Linux-2.4.25</i></font>
<br><font size=2 face="sans-serif"><i>&nbsp; &nbsp;Image Type: &nbsp; PowerPC
Linux Kernel Image (gzip compressed)</i></font>
<br><font size=2 face="sans-serif"><i>&nbsp; &nbsp;Data Size: &nbsp; &nbsp;603830
Bytes = 589.7 kB</i></font>
<br><font size=2 face="sans-serif"><i>&nbsp; &nbsp;Load Address: 00000000</i></font>
<br><font size=2 face="sans-serif"><i>&nbsp; &nbsp;Entry Point: &nbsp;00000000</i></font>
<br><font size=2 face="sans-serif"><i>&nbsp; &nbsp;Verifying Checksum ...
OK</i></font>
<br><font size=2 face="sans-serif"><i>&nbsp; &nbsp;Uncompressing Kernel
Image ... </i></font>
<br>
<br><font size=2 face="sans-serif">The system hangs here and is not able
to uncompress the kernel any further. I have checked in the FAQs provided
in the denx's site, but could not find anything similar to my case.</font>
<br>
<br><font size=2 face="sans-serif">I would appreciate any help.</font>
<br>
<br><font size=2 face="sans-serif">Thanks &amp; Regards,<br>
Pritha Bhattacharya<br>
Tata Consultancy Services Limited<br>
Mailto: pritha.bhattacharya@tcs.com<br>
Website: http://www.tcs.com</font>
<table><tr><td bgcolor=#ffffff><font color=#000000>Notice: The information contained in this e-mail message and/or attachments to it may contain confidential or privileged information.   If you are not the intended recipient, any dissemination, use, review, distribution, printing or copying of the information contained in this e-mail message and/or attachments to it are strictly prohibited.   If you have received this communication in error, please notify us by reply e-mail or telephone and immediately and permanently delete the message and any attachments.  Thank you<br>
</font></td></tr></table>
--=_alternative 0036D983652570CA_=--
