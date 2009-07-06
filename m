Return-Path: <BLandau@nds.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B98AFB7066
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  6 Jul 2009 22:10:21 +1000 (EST)
Received: from ilsmtp.nds.com (ilsmtp.nds.com [192.118.32.12])
	by ozlabs.org (Postfix) with ESMTP id B17CFDDD01
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Jul 2009 22:10:20 +1000 (EST)
From: "Landau, Bracha" <BLandau@nds.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Date: Mon, 6 Jul 2009 15:03:55 +0300
Subject: tcsetattr doesn't change baud rate
Message-ID: <065A7D06F7D4E546A18E80E08D066E18118A03BED7@ILMA1.IL.NDS.COM>
Content-Type: multipart/alternative;
	boundary="_000_065A7D06F7D4E546A18E80E08D066E18118A03BED7ILMA1ILNDSCOM_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_000_065A7D06F7D4E546A18E80E08D066E18118A03BED7ILMA1ILNDSCOM_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I have re-ported an application that ran (and worked) on linux kernel 2.6.1=
4 (with Xenomai).
Now it works on linux kernel 2.6.29.4.
When I do tcsetattr to change the baud rate (from 9600 to 38400) the functi=
on returns without an error, but does not actually change the baud rate, an=
d it remains at 9600. This is despite using the flag "TCSANOW" when request=
ing the change.
Any ideas why this is happening?


________________________________
This e-mail is confidential, the property of NDS Ltd and intended for the a=
ddressee only. Any dissemination, copying or distribution of this message o=
r any attachments by anyone other than the intended recipient is strictly p=
rohibited. If you have received this message in error, please immediately n=
otify the postmaster@nds.com and destroy the original message. Messages sen=
t to and from NDS may be monitored. NDS cannot guarantee any message delive=
ry method is secure or error-free. Information could be intercepted, corrup=
ted, lost, destroyed, arrive late or incomplete, or contain viruses. We do =
not accept responsibility for any errors or omissions in this message and/o=
r attachment that arise as a result of transmission. You should carry out y=
our own virus checks before opening any attachment. Any views or opinions p=
resented are solely those of the author and do not necessarily represent th=
ose of NDS.

To protect the environment please do not print this e-mail unless necessary=
.

NDS Limited Registered Office: One London Road, Staines,Middlesex TW18 4EX,=
 United Kingdom. A company registered in England and Wales Registered no. 3=
080780 VAT no. GB 603 8808 40-00

--_000_065A7D06F7D4E546A18E80E08D066E18118A03BED7ILMA1ILNDSCOM_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta content=3D"MSHTML 6.00.2900.3527" name=3D"GENERATOR">
</head>
<body>
<div><font face=3D"Arial" size=3D"2"><span class=3D"781185811-06072009">I h=
ave re-ported an application that ran (and worked) on linux kernel 2.6.14 (=
with Xenomai).</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"781185811-06072009">Now=
 it works on linux kernel 2.6.29.4.</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"781185811-06072009">Whe=
n I do tcsetattr to&nbsp;change the baud rate (from 9600 to 38400) the func=
tion returns without an error, but does not actually change the baud rate, =
and it remains at 9600. This is despite using
 the flag &quot;TCSANOW&quot; when requesting the change.</span></font></di=
v>
<div><font face=3D"Arial" size=3D"2"><span class=3D"781185811-06072009">Any=
 ideas why this is happening?</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"781185811-06072009"></s=
pan></font>&nbsp;</div>
<br>
<hr>
<font face=3D"Arial" color=3D"Gray" size=3D"1">This e-mail is confidential,=
 the property of NDS Ltd and intended for the addressee only. Any dissemina=
tion, copying or distribution of this message or any attachments by anyone =
other than the intended recipient is strictly
 prohibited. If you have received this message in error, please immediately=
 notify the postmaster@nds.com and destroy the original message. Messages s=
ent to and from NDS may be monitored. NDS cannot guarantee any message deli=
very method is secure or error-free.
 Information could be intercepted, corrupted, lost, destroyed, arrive late =
or incomplete, or contain viruses. We do not accept responsibility for any =
errors or omissions in this message and/or attachment that arise as a resul=
t of transmission. You should carry
 out your own virus checks before opening any attachment. Any views or opin=
ions presented are solely those of the author and do not necessarily repres=
ent those of NDS.<br>
<br>
To protect the environment please do not print this e-mail unless necessary=
.<br>
<br>
NDS Limited Registered Office: One London Road, Staines,Middlesex TW18 4EX,=
 United Kingdom. A company registered in England and Wales Registered no. 3=
080780 VAT no. GB 603 8808 40-00<br>
</font>
</body>
</html>

--_000_065A7D06F7D4E546A18E80E08D066E18118A03BED7ILMA1ILNDSCOM_--
