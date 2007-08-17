Return-Path: <ravi.rao@rflelect.com>
Received: from noteshub1.teal.com (mail.teal.com [67.155.213.211])
	by ozlabs.org (Postfix) with ESMTP id 26727DDE20
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 18 Aug 2007 00:22:33 +1000 (EST)
To: linuxppc-embedded@ozlabs.org
Subject: Re: system hang in early_init
MIME-Version: 1.0
Message-ID: <OF1175F445.15D3933E-ON8525733A.004D6246-8525733A.004D7B50@rflelect.com>
From: ravi.rao@rflelect.com
Date: Fri, 17 Aug 2007 10:07:21 -0400
Content-Type: multipart/alternative;
	boundary="=_alternative 004D7B488525733A_="
Cc: IS_Department%TealCorp@rflelect.com
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
--=_alternative 004D7B488525733A_=
Content-Type: text/plain; charset="US-ASCII"

Hi Chris,
    It seems that my PPC405 V2Pro system is hanging in the function 
early_init, in arch/ppc/kernel/setup.c. Using LEDs, I've been able to 
determine that the following line seems to be where it dies:
memset_io(PTRRELOC(&__bss_start), 0, _end - __bss_start);

Looking in System.map, I see that __bss_start is 0xC013F000 and _end is 
0xC014DA60, with a whole bunch of stuff in between.
Any idea what might cause this?

I saw Ur posting on the net I am facing the same problem with my EP405 
target . Did you resolve the problem if so can you please provide me some 
info..
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
 
 
 
--=_alternative 004D7B488525733A_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hi Chris,</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; </font><font size=3><tt>It
seems that my PPC405 V2Pro system is hanging in the function <br>
early_init, in arch/ppc/kernel/setup.c. Using LEDs, I've been able to <br>
determine that the following line seems to be where it dies:<br>
memset_io(PTRRELOC(&amp;__bss_start), 0, _end - __bss_start);<br>
<br>
Looking in System.map, I see that __bss_start is 0xC013F000 and _end is
<br>
0xC014DA60, with a whole bunch of stuff in between.<br>
Any idea what might cause this?</tt></font>
<br>
<br><font size=2 face="sans-serif">I saw Ur posting on the net I am facing
the same problem with my EP405 target . Did you resolve the problem if
so can you please provide me some info..</font>
<br><font size=2 face="sans-serif">Thanks,<br>
</font><font size=2 face="Tms Rmn">Ravishankar Govindarao<br>
RFL Electronics Inc.<br>
E-mail</font><font size=1 face="Tms Rmn"> </font><font size=2 face="Tms Rmn">:
</font><a href=mailto:Ravi.Rao@rflelect.com><font size=2 color=blue face="Tms Rmn"><u>Ravi.Rao@rflelect.com</u></font></a>
<br><font size=2 face="Tms Rmn">Voice: 973.334.3100 Ext. 233<br>
Fax: 973.334.3863</font>
<p><font size=2 face="Tms Rmn">&nbsp;</font>
<div align=center>
<br><font size=2 color=blue face="Tms Rmn"><u>CONFIDENTIALITY NOTE</u></font></div>
<br><font size=1 face="Tms Rmn">This e-mail, including any attachments,
may contain confidential and/or legally privileged information.&nbsp; The
Information is intended only for the use of the individual or entity named
on this e-mail</font><font size=1 face="Tms Rmn"> </font><font size=1 face="Tms Rmn">.&nbsp;
If you are not the intended recipient, you are hereby notified that any
disclosure, copying, distribution, or the taking of any action in reliance
on the contents of this transmitted Information is strictly prohibited.&nbsp;
Further, if you are not the intended recipient, please notify us by return
e-mail and delete the Information promptly.</font>
<p><font size=2 face="Tms Rmn">&nbsp;</font>
<p><font size=2 face="Tms Rmn">&nbsp;</font>
<p><font size=3>&nbsp;</font>
--=_alternative 004D7B488525733A_=--
