Return-Path: <prabha.j@tcs.com>
Received: from INKOLG01.tcs.com (inkolg01.tcs.com [203.197.96.54])
	by ozlabs.org (Postfix) with ESMTP id 6B82168879
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Dec 2005 16:47:03 +1100 (EST)
To: ppc <linuxppc-embedded@ozlabs.org>
MIME-Version: 1.0
From: prabha.j@tcs.com
Message-ID: <OF9DE214F2.0E95797E-ON652570D6.001EADA0-652570D6.001FA18E@tcs.com>
Date: Tue, 13 Dec 2005 11:15:29 +0530
Content-Type: multipart/alternative;
	boundary="=_alternative 001FA12F652570D6_="
Subject: help reqd
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
--=_alternative 001FA12F652570D6_=
Content-Type: text/plain; charset="US-ASCII"


Hi All,
I am having custom board which is similar to MPC8260ADS board. I want to 
port linux on this board. I am having TRACE32 debugger.
When i put breakpoint on load_up_mmu, it won't stop at this point. It 
shows running in the status bar and when i give  break, it goes to panic 
symbol and it hangs there. I cannot proceed further. Then i have to reload 
the cmm file again.
Can any one tell me  what and where  is the problem.
I am using Linux-2.4.25 from denx and my boards memory map is 
SDRAM 128MB(0x00000000) and Flash 1MB(starts from 0x30000000).
Thanks in advance.
best regards

Prabha J.
Tata Consultancy Services Limited
Mailto: prabha.j@tcs.com
Website: http://www.tcs.com

Notice: The information contained in this e-mail message and/or attachments to it may contain confidential or privileged information.   If you are not the intended recipient, any dissemination, use, review, distribution, printing or copying of the information contained in this e-mail message and/or attachments to it are strictly prohibited.   If you have received this communication in error, please notify us by reply e-mail or telephone and immediately and permanently delete the message and any attachments.  Thank you
--=_alternative 001FA12F652570D6_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hi All,</font>
<br><font size=2 face="sans-serif">I am having custom board which is similar
to MPC8260ADS board. I want to port linux on this board. I am having TRACE32
debugger.</font>
<br><font size=2 face="sans-serif">When i put breakpoint on load_up_mmu,
it won't stop at this point. It shows running in the status bar and when
i give &nbsp;break, it goes to panic symbol and it hangs there. I cannot
proceed further. Then i have to reload the cmm file again.</font>
<br><font size=2 face="sans-serif">Can any one tell me &nbsp;what and where
&nbsp;is the problem.</font>
<br><font size=2 face="sans-serif">I am using Linux-2.4.25 from denx and
my boards memory map is </font>
<br><font size=2 face="sans-serif">SDRAM 128MB(0x00000000) and Flash 1MB(starts
from 0x30000000).</font>
<br><font size=2 face="sans-serif">Thanks in advance.</font>
<br><font size=2 face="sans-serif">best regards</font>
<br><font size=2 face="sans-serif"><br>
Prabha J.<br>
Tata Consultancy Services Limited<br>
Mailto: prabha.j@tcs.com<br>
Website: http://www.tcs.com</font>
<table><tr><td bgcolor=#ffffff><font color=#000000>Notice: The information contained in this e-mail message and/or attachments to it may contain confidential or privileged information.   If you are not the intended recipient, any dissemination, use, review, distribution, printing or copying of the information contained in this e-mail message and/or attachments to it are strictly prohibited.   If you have received this communication in error, please notify us by reply e-mail or telephone and immediately and permanently delete the message and any attachments.  Thank you<br>
</font></td></tr></table>
--=_alternative 001FA12F652570D6_=--
