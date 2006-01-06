Return-Path: <batsayan.das@tcs.com>
Received: from INKOLG01.tcs.com (inkolg01.tcs.com [203.197.96.54])
	by ozlabs.org (Postfix) with ESMTP id 7067F688DC
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 Jan 2006 00:13:41 +1100 (EST)
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
From: batsayan.das@tcs.com
Message-ID: <OF114C07C5.7CED9F64-ON652570EE.00481B82-652570EE.00489CCF@tcs.com>
Date: Fri, 6 Jan 2006 18:43:08 +0530
Content-Type: multipart/alternative;
	boundary="=_alternative 00489B41652570EE_="
Subject: How to enable PHY
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
--=_alternative 00489B41652570EE_=
Content-Type: text/plain; charset="US-ASCII"


Hi,

I found that ADS8260 board enables PHY by the following lines of code

#ifndef CONFIG_ADS8260
        /* Enable the PHY.
        */
        *(volatile uint *)(BCSR_ADDR + 4) &= ~BCSR1_FETHIEN;
        *(volatile uint *)(BCSR_ADDR + 4) |=  BCSR1_FETH_RST;
#endif


Our board does not have BCSR. My question is how to enable PHY for MPC8260 
based customs board without BCSR? 

Thanks,
Batsayan Das
Tata Consultancy Services Limited
Mailto: batsayan.das@tcs.com
Website: http://www.tcs.com

Notice: The information contained in this e-mail message and/or attachments to it may contain confidential or privileged information.   If you are not the intended recipient, any dissemination, use, review, distribution, printing or copying of the information contained in this e-mail message and/or attachments to it are strictly prohibited.   If you have received this communication in error, please notify us by reply e-mail or telephone and immediately and permanently delete the message and any attachments.  Thank you
--=_alternative 00489B41652570EE_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hi,</font>
<br>
<br><font size=2 face="sans-serif">I found that ADS8260 board enables PHY
by the following lines of code</font>
<br>
<br><font size=2 face="sans-serif">#ifndef CONFIG_ADS8260</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; /* Enable
the PHY.</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; */</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; *(volatile
uint *)(BCSR_ADDR + 4) &amp;= ~BCSR1_FETHIEN;</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; *(volatile
uint *)(BCSR_ADDR + 4) |= &nbsp;BCSR1_FETH_RST;</font>
<br><font size=2 face="sans-serif">#endif</font>
<br>
<br>
<br><font size=2 face="sans-serif">Our board does not have BCSR. My question
is how to enable PHY for MPC8260 based customs board without BCSR? </font>
<br>
<br><font size=2 face="sans-serif">Thanks,<br>
Batsayan Das<br>
Tata Consultancy Services Limited<br>
Mailto: batsayan.das@tcs.com<br>
Website: http://www.tcs.com</font>
<table><tr><td bgcolor=#ffffff><font color=#000000>Notice: The information contained in this e-mail message and/or attachments to it may contain confidential or privileged information.   If you are not the intended recipient, any dissemination, use, review, distribution, printing or copying of the information contained in this e-mail message and/or attachments to it are strictly prohibited.   If you have received this communication in error, please notify us by reply e-mail or telephone and immediately and permanently delete the message and any attachments.  Thank you<br>
</font></td></tr></table>
--=_alternative 00489B41652570EE_=--
