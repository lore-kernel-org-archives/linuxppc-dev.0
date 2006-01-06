Return-Path: <batsayan.das@tcs.com>
Received: from INKOLG01.tcs.com (inkolg01.tcs.com [203.197.96.54])
	by ozlabs.org (Postfix) with ESMTP id 4835D68910
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 Jan 2006 22:14:23 +1100 (EST)
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
From: batsayan.das@tcs.com
Message-ID: <OFE75E4E98.D56217BF-ON652570EE.0039B69D-652570EE.003AEEB0@tcs.com>
Date: Fri, 6 Jan 2006 16:13:42 +0530
Content-Type: multipart/alternative;
	boundary="=_alternative 003AEE7E652570EE_="
Subject: Help on LXT971 eth initialization
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
--=_alternative 003AEE7E652570EE_=
Content-Type: text/plain; charset="US-ASCII"


Hi,

My MPC8260 customs board has LXT971 Ethernet chip on FCC1. I am able to 
get the linux prompt, but I am unable to initialize ethernet. I have tried 
different bootarg options (like setenv bootargs ip=dhcp etc)  and 
different kernel compilation options (like from make menuconfig, Network 
Option->enable DHCP support etc), but none enables the ethernet interface. 


Any help will be appreciated.

FYI, the ethernet is working from U-Boot. 

Thanks,
Batsayan Das
Tata Consultancy Services Limited
Mailto: batsayan.das@tcs.com
Website: http://www.tcs.com

Notice: The information contained in this e-mail message and/or attachments to it may contain confidential or privileged information.   If you are not the intended recipient, any dissemination, use, review, distribution, printing or copying of the information contained in this e-mail message and/or attachments to it are strictly prohibited.   If you have received this communication in error, please notify us by reply e-mail or telephone and immediately and permanently delete the message and any attachments.  Thank you
--=_alternative 003AEE7E652570EE_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hi,</font>
<br>
<br><font size=2 face="sans-serif">My MPC8260 customs board has LXT971
Ethernet chip on FCC1. I am able to get the linux prompt, but I am unable
to initialize ethernet. I have tried different bootarg options (like setenv
bootargs ip=dhcp etc) &nbsp;and different kernel compilation options (like
from make menuconfig, Network Option-&gt;enable DHCP support etc), but
none enables the ethernet interface. </font>
<br>
<br><font size=2 face="sans-serif">Any help will be appreciated.</font>
<br>
<br><font size=2 face="sans-serif">FYI, the ethernet is working from U-Boot.
</font>
<br><font size=2 face="sans-serif"><br>
Thanks,</font>
<br><font size=2 face="sans-serif">Batsayan Das<br>
Tata Consultancy Services Limited<br>
Mailto: batsayan.das@tcs.com<br>
Website: http://www.tcs.com</font>
<table><tr><td bgcolor=#ffffff><font color=#000000>Notice: The information contained in this e-mail message and/or attachments to it may contain confidential or privileged information.   If you are not the intended recipient, any dissemination, use, review, distribution, printing or copying of the information contained in this e-mail message and/or attachments to it are strictly prohibited.   If you have received this communication in error, please notify us by reply e-mail or telephone and immediately and permanently delete the message and any attachments.  Thank you<br>
</font></td></tr></table>
--=_alternative 003AEE7E652570EE_=--
