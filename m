Return-Path: <ravi.rao@rflelect.com>
In-Reply-To: <66E8AEE9980BB44CA5FCAD39EBA56AC6029A29DD@CHN-HCLT-EVS02.HCLT.CORP.HCL.IN>
To: avenkatesh@hcl.in
Subject: Re: cross compilation issue
MIME-Version: 1.0
Message-ID: <OF1782007A.A1A7A36C-ON85257376.005181BD-85257376.00519317@rflelect.com>
From: ravi.rao@rflelect.com
Date: Tue, 16 Oct 2007 10:51:40 -0400
Content-Type: multipart/alternative;
	boundary="=_alternative 0051931585257376_="
Cc: linuxppc-embedded-bounces+ravi.rao=rflelect.com@ozlabs.org,
	linuxppc-embedded@ozlabs.org
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
--=_alternative 0051931585257376_=
Content-Type: text/plain; charset="US-ASCII"

Hi,
 Easiest way is to edit the x86 Makefile so that gcc and ld points to Ur 
tool chain's ppc_6xx-gcc & ppc_6xx-ld..
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
 
 
 



"Venkatesh Ananthakrishnan, TLS-Chennai" <avenkatesh@hcl.in> 
Sent by: linuxppc-embedded-bounces+ravi.rao=rflelect.com@ozlabs.org
10/16/2007 10:24 AM

To
<linuxppc-embedded@ozlabs.org>
cc

Subject
cross compilation issue






Hai
I am newbi to linux.
I wrote the application usb libusb which works fine with x86 pc.
I want to compile the application for ppc. I have cross compiled libusb. I 
have tool chain also.
If I give ppc_6xx-gcc filename.c 
It gives the error message as usb.h No such a file or directory.
How to give include path and library path during compilation?
Please do the needful
 
Regards,
Venkatesh
 

DISCLAIMER:
-----------------------------------------------------------------------------------------------------------------------

The contents of this e-mail and any attachment(s) are confidential and 
intended for the named recipient(s) only.
It shall not attach any liability on the originator or HCL or its 
affiliates. Any views or opinions presented in 
this email are solely those of the author and may not necessarily reflect 
the opinions of HCL or its affiliates.
Any form of reproduction, dissemination, copying, disclosure, 
modification, distribution and / or publication of 
this message without the prior written consent of the author of this 
e-mail is strictly prohibited. If you have 
received this email in error please delete it and notify the sender 
immediately. Before opening any mail and 
attachments please check them for viruses and defect.

-----------------------------------------------------------------------------------------------------------------------
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded

--=_alternative 0051931585257376_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hi,</font>
<br><font size=2 face="sans-serif">&nbsp;Easiest way is to edit the x86
Makefile so that gcc and ld points to Ur tool chain's </font><font size=2 face="Arial">ppc_6xx-gcc</font><font size=2 face="sans-serif">
&amp; </font><font size=2 face="Arial">ppc_6xx-ld..</font>
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
<br>
<br>
<br>
<table width=100%>
<tr valign=top>
<td width=40%><font size=1 face="sans-serif"><b>&quot;Venkatesh Ananthakrishnan,
TLS-Chennai&quot; &lt;avenkatesh@hcl.in&gt;</b> </font>
<br><font size=1 face="sans-serif">Sent by: linuxppc-embedded-bounces+ravi.rao=rflelect.com@ozlabs.org</font>
<p><font size=1 face="sans-serif">10/16/2007 10:24 AM</font>
<td width=59%>
<table width=100%>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">To</font></div>
<td><font size=1 face="sans-serif">&lt;linuxppc-embedded@ozlabs.org&gt;</font>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">cc</font></div>
<td>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">Subject</font></div>
<td><font size=1 face="sans-serif">cross compilation issue</font></table>
<br>
<table>
<tr valign=top>
<td>
<td></table>
<br></table>
<br>
<br>
<br><font size=2 face="Arial">Hai</font>
<br><font size=2 face="Arial">I am newbi to linux.</font>
<br><font size=2 face="Arial">I wrote the application usb libusb which
works fine with x86 pc.</font>
<br><font size=2 face="Arial">I want to compile the application for ppc.
I have cross compiled libusb. I have tool chain also.</font>
<br><font size=2 face="Arial">If I give ppc_6xx-gcc filename.c </font>
<br><font size=2 face="Arial">It gives the error message as usb.h No such
a file or directory.</font>
<br><font size=2 face="Arial">How to give include path and library path
during compilation?</font>
<br><font size=2 face="Arial">Please do the needful</font>
<br><font size=2 face="Arial">&nbsp;</font>
<br><font size=2 face="Arial">Regards,</font>
<br><font size=2 face="Arial">Venkatesh</font>
<br><font size=2 face="Arial">&nbsp;</font>
<p>
<table width=100%>
<tr>
<td width=100% bgcolor=white><font size=3>DISCLAIMER:<br>
-----------------------------------------------------------------------------------------------------------------------<br>
<br>
The contents of this e-mail and any attachment(s) are confidential and
intended for the named recipient(s) only.<br>
It shall not attach any liability on the originator or HCL or its affiliates.
Any views or opinions presented in <br>
this email are solely those of the author and may not necessarily reflect
the opinions of HCL or its affiliates.<br>
Any form of reproduction, dissemination, copying, disclosure, modification,
distribution and / or publication of <br>
this message without the prior written consent of the author of this e-mail
is strictly prohibited. If you have <br>
received this email in error please delete it and notify the sender immediately.
Before opening any mail and <br>
attachments please check them for viruses and defect.<br>
<br>
-----------------------------------------------------------------------------------------------------------------------</font></table>
<br><font size=2><tt>_______________________________________________<br>
Linuxppc-embedded mailing list<br>
Linuxppc-embedded@ozlabs.org<br>
https://ozlabs.org/mailman/listinfo/linuxppc-embedded</tt></font>
<br>
--=_alternative 0051931585257376_=--
