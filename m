Return-Path: <pjmaiya@signal-networks.com>
Received: from smtp.net4india.com (smtp.net4india.com [202.71.129.68])
	by ozlabs.org (Postfix) with ESMTP id 753E9DDF14
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Feb 2008 18:22:01 +1100 (EST)
Received: from [61.95.204.104] (helo=signal-networks.com)
	by smtp.net4india.com with esmtp (Exim 4.54) id 1JMi60-0006h5-6t
	for linuxppc-embedded@ozlabs.org; Wed, 06 Feb 2008 16:35:40 +0530
Received: from pjmaiya ([192.168.1.77])
	by signal-networks.com (mail.signal-networks.com [192.168.1.1])
	(MDaemon Standard v9.5.6) with ESMTP id md50000182031.msg
	for <linuxppc-embedded@ozlabs.org>; Wed, 06 Feb 2008 16:46:49 +0530
Message-ID: <003b01c868b1$c23f5650$4d01a8c0@signet>
From: "pjmaiya" <pjmaiya@signal-networks.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: html tag creation using 'C'
Date: Wed, 6 Feb 2008 16:46:45 +0530
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0038_01C868DF.DBE6F080"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_0038_01C868DF.DBE6F080
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

hi,
  Using 'C' code I need to generate HTML tag for 'table' creation. Each =
table row may contain one more table and I need to control each =
parameter of the table.
I don't want to use printf since my table may grow dyanmically. I want =
to use data structure(especially linked list).
Does anybody has idea on this.=20

To organzie my data in HTML page, I will be putting data inside 'table'. =
This organization becomes complex as different group of data arises.
Each cell of table may contain one more table to show these grouped =
data.

For example.

Table1
_ _ _ __ _ _ _ _ _ _ __ _ _ _ _
|           |         |                    |
| _Table2 _  _  | _  _ _ __ _ _ |
|           |        |                     |=20
| _ _ _  | _  _  | _  _ _ _ _  _ _|                   =20
|                    |                     |
|_ _ _ __ _ _ _|_ _ _ __ _ _ _ |


pjmaiya
------=_NextPart_000_0038_01C868DF.DBE6F080
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1605" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>hi,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp; Using 'C' code I need to =
generate HTML tag=20
for <STRONG>'table'</STRONG> creation. Each table row may contain one =
more table=20
and I need to control each parameter of the table.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I don't want to use&nbsp;printf since =
my table may=20
grow dyanmically. I want to use data structure(especially linked=20
list).</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Does anybody has idea on this. =
</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>To organzie my data in HTML page, I =
will be putting=20
data inside 'table'. This organization becomes complex as different =
group of=20
data arises.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Each cell of table may contain one more =
table to=20
show these grouped data.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>For example.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Table1</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>_ _ _ __ _ _ _ _ _ _ __ _ _ _ =
_</FONT></DIV>
<DIV><FONT face=3DArial=20
size=3D2>|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
|</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>|&nbsp;_Table2 _&nbsp; _&nbsp; | =
_&nbsp; _&nbsp;_=20
__&nbsp;_ _ |</FONT></DIV>
<DIV><FONT face=3DArial=20
size=3D2>|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
&nbsp;| </FONT></DIV>
<DIV><FONT face=3DArial size=3D2>|&nbsp;_&nbsp;_&nbsp;_&nbsp;=20
|&nbsp;_&nbsp;&nbsp;_&nbsp; |&nbsp;_&nbsp;&nbsp;_=20
_&nbsp;_&nbsp;_&nbsp;&nbsp;_&nbsp;_|&nbsp;</FONT><FONT face=3DArial=20
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</FONT></DIV>
<DIV><FONT face=3DArial=20
size=3D2>|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
|</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>|_ _ _ __ _ _ _|_ _ _ __ _ _ _ =
|</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT><FONT face=3DArial =
size=3D2></FONT><FONT=20
face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>pjmaiya</FONT></DIV></BODY></HTML>

------=_NextPart_000_0038_01C868DF.DBE6F080--
