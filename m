Return-Path: <ravi.rao@rflelect.com>
Received: from noteshub1.teal.com (mail.teal.com [67.155.213.211])
	by ozlabs.org (Postfix) with ESMTP id 291D6DDE20
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  5 Jan 2008 07:58:14 +1100 (EST)
In-Reply-To: <14612548.post@talk.nabble.com>
To: linuxlink-help@timesys.com
Subject: Control not branching to the instruction present at resetvec i.e
	0xfffffffc
MIME-Version: 1.0
Message-ID: <OFD408300E.ACB35FD3-ON852573C6.0072065E-852573C6.007337FA@RFLELECT.COM>
From: ravi.rao@rflelect.com
Date: Fri, 4 Jan 2008 15:58:08 -0500
Content-Type: multipart/alternative;
	boundary="=_alternative 007337F5852573C6_="
Cc: Miki.Groftisza@rflelect.com, linuxppc-embedded@ozlabs.org
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
--=_alternative 007337F5852573C6_=
Content-Type: text/plain; charset="US-ASCII"

Hi All,
    We have a custom target board based on PPC-EP405. We just got the 
board from the hardware team .I connected the board to BDI200 and powered 
it on. 
The control came to the resetvec address which is 0xfffffffc. I was able 
to read and write to flash. So I erased the flash and burnt the bootloader 
into flash from 0xfffc0000.
I verified that the instruction at 0xfffffffc is 4bfc2104 whicis actually 
a branch to 0xfffc2100. Also a memory dump of 0xfffc2100 shows the correct 
code. This proved that
the uboot bootloader was burnt properly.
Now when I reset the board the control never reaches 0xfffc2100 i.e for 
some reason the code at the resetvec is not getting executed. Any help or 
pointers to resolve this is greatly appreciated.
Thanks,
Ravishankar Govindarao
RFL Electronics Inc.
E-mail : Ravi.Rao@rflelect.com
Voice: 973.334.3100 Ext. 233
Fax: 973.334.3863
 
CONFIDENTIALITY NOTE
This e-mail, including any attachments, may contain confidential and/or 
legally privileged information.  The Information is intended only for the 
use of the individual or entity named on this e-mail .  If you are not the 
intended recipient, you are hereby notified that any disclosure, copying, 
distribution, or the taking of any action in reliance on the contents of 
this transmitted Information is strictly prohibited.  Further, if you are 
not the intended recipient, please notify us by return e-mail and delete 
the Information promptly.
 
 
 
--=_alternative 007337F5852573C6_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hi All,</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; We have a custom target
board based on PPC-EP405. We just got the board from the hardware team
.I connected the board to BDI200 and powered it on. </font>
<br><font size=2 face="sans-serif">The control came to the resetvec address
which is 0xfffffffc. I was able to read and write to flash. So I erased
the flash and burnt the bootloader into flash from 0xfffc0000.</font>
<br><font size=2 face="sans-serif">I verified that the instruction at 0xfffffffc
is <b>4bfc2104 </b>whicis actually a branch to 0xfffc2100. Also a memory
dump of 0xfffc2100 shows the correct code. This proved that</font>
<br><font size=2 face="sans-serif">the uboot bootloader was burnt properly.</font>
<br><font size=2 face="sans-serif">Now when I reset the board the control
never reaches 0xfffc2100 i.e for some reason the code at the resetvec is
not getting executed. Any help or pointers to resolve this is greatly appreciated.</font>
<br><font size=2 face="sans-serif">Thanks,<br>
</font><font size=2>Ravishankar Govindarao<br>
RFL Electronics Inc.<br>
E-mail</font><font size=1> </font><font size=2>: </font><a href=mailto:Ravi.Rao@rflelect.com><font size=2 color=blue><u>Ravi.Rao@rflelect.com</u></font></a>
<br><font size=2>Voice: 973.334.3100 Ext. 233<br>
Fax: 973.334.3863</font>
<p><font size=2>&nbsp;</font>
<div align=center>
<br><font size=2 color=blue><u>CONFIDENTIALITY NOTE</u></font></div>
<br><font size=1>This e-mail, including any attachments, may contain confidential
and/or legally privileged information.&nbsp; The Information is intended
only for the use of the individual or entity named on this e-mail</font><font size=1>
</font><font size=1>.&nbsp; If you are not the intended recipient, you
are hereby notified that any disclosure, copying, distribution, or the
taking of any action in reliance on the contents of this transmitted Information
is strictly prohibited.&nbsp; Further, if you are not the intended recipient,
please notify us by return e-mail and delete the Information promptly.</font>
<p><font size=2>&nbsp;</font>
<p><font size=2>&nbsp;</font>
<p><font size=3>&nbsp;</font>
--=_alternative 007337F5852573C6_=--
