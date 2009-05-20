Return-Path: <BLandau@nds.com>
Received: from ilsmtp.nds.com (ilsmtp.nds.com [192.118.32.12])
	by ozlabs.org (Postfix) with ESMTP id 8F333DE114
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 02:40:36 +1000 (EST)
From: "Landau, Bracha" <BLandau@nds.com>
To: Scott Wood <scottwood@freescale.com>, "linuxppc-dev@ozlabs.org"
	<linuxppc-dev@ozlabs.org>
Date: Wed, 20 May 2009 19:40:32 +0300
Subject: no rx interrupts on mpc8272-based board
Message-ID: <065A7D06F7D4E546A18E80E08D066E181189D54939@ILMA1.IL.NDS.COM>
Content-Type: multipart/alternative;
	boundary="_000_065A7D06F7D4E546A18E80E08D066E181189D54939ILMA1ILNDSCOM_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--_000_065A7D06F7D4E546A18E80E08D066E181189D54939ILMA1ILNDSCOM_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I have ported Linux-2-6-29 to my MPC8272 based board, very similar to the M=
PC8272ADS. I am using a cuImage.
Things seem to be working ok except that I am not getting any FEC interrupt=
s (on IRQ5).
I see that I am transmitting ok.
Any ideas where the problem could be?


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

--_000_065A7D06F7D4E546A18E80E08D066E181189D54939ILMA1ILNDSCOM_
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
<div><font face=3D"Arial" size=3D"2"><span class=3D"218543416-20052009">I h=
ave ported Linux-2-6-29 to my MPC8272 based board, very similar to the MPC8=
272ADS. I am using a cuImage.</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"218543416-20052009">Thi=
ngs seem to be working ok except that I am not getting any FEC interrupts (=
on IRQ5).</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"218543416-20052009">I s=
ee that I am transmitting ok.</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"218543416-20052009">Any=
 ideas where&nbsp;the problem could be?</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"218543416-20052009"></s=
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

--_000_065A7D06F7D4E546A18E80E08D066E181189D54939ILMA1ILNDSCOM_--
