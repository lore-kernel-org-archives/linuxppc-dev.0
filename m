Return-Path: <BLandau@nds.com>
Received: from ilsmtp.nds.com (ilsmtp.nds.com [192.118.32.12])
	by ozlabs.org (Postfix) with ESMTP id EC870DDDEE
	for <linuxppc-dev@ozlabs.org>; Sun,  3 May 2009 17:22:35 +1000 (EST)
From: "Landau, Bracha" <BLandau@nds.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Date: Sun, 3 May 2009 10:16:29 +0300
Subject: help with MPC8272ADS board
Message-ID: <065A7D06F7D4E546A18E80E08D066E1811892DD86B@ILMA1.IL.NDS.COM>
Content-Type: multipart/alternative;
	boundary="_000_065A7D06F7D4E546A18E80E08D066E1811892DD86BILMA1ILNDSCOM_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--_000_065A7D06F7D4E546A18E80E08D066E1811892DD86BILMA1ILNDSCOM_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm trying to get the MPC8272ADS evaluation board up and running with the l=
atest versions of u-boot and Denx linux (2.6.24).

I use the device tree file (mpc8272ads.dts) provided. Based on another post=
, I updated the MPC8260ADS.h file, changing OF_CPU from "cpu@0<mailto:cpu@0=
>" to "PowerPC,8272@0", because I was getting an error.

I tried booting both using a cuImage (cuImage.mpc8272ads) and a uImage with=
 a device tree blob. Neither boot was successful, with no helpful informati=
on printed to the serial port.

Is there any change that has to be made in order to get the board to boot?

Bracha Landau







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

--_000_065A7D06F7D4E546A18E80E08D066E1811892DD86BILMA1ILNDSCOM_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta content=3D"MSHTML 6.00.2900.3492" name=3D"GENERATOR">
</head>
<body>
<div><font face=3D"Arial" size=3D"2"><span class=3D"703545106-03052009">Hi,=
</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"703545106-03052009"></s=
pan></font>&nbsp;</div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"703545106-03052009">I'm=
 trying to get the MPC8272ADS evaluation board up and running with the late=
st versions of u-boot and Denx linux (2.6.24).</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"703545106-03052009"></s=
pan></font>&nbsp;</div>
<div><span class=3D"703545106-03052009"><font face=3D"Arial" size=3D"2">I u=
se the device tree file (mpc8272ads.dts) provided. Based on another post, I=
 updated the MPC8260ADS.h file, changing OF_CPU from &quot;</font><a href=
=3D"mailto:cpu@0"><font face=3D"Arial" color=3D"#000000" size=3D"2">cpu@0</=
font></a><font face=3D"Arial" size=3D"2">&quot;&nbsp;</font></span><span cl=
ass=3D"703545106-03052009"><font face=3D"Arial" size=3D"2">to
 &quot;PowerPC,8272@0&quot;, because I was getting an error.</font></span><=
/div>
<div><span class=3D"703545106-03052009"><font face=3D"Arial" size=3D"2"></f=
ont></span>&nbsp;</div>
<div><span class=3D"703545106-03052009"><font face=3D"Arial" size=3D"2">I t=
ried booting both using a cuImage (cuImage.mpc8272ads) and a uImage with a =
device tree blob. Neither boot was successful, with no helpful information =
printed to the serial port.</font></span></div>
<div><span class=3D"703545106-03052009"><font face=3D"Arial" size=3D"2"></f=
ont></span>&nbsp;</div>
<div><span class=3D"703545106-03052009"><font face=3D"Arial" size=3D"2">Is =
there any change that has to be made in order to get the board to boot?</fo=
nt></span></div>
<div><span class=3D"703545106-03052009"><font face=3D"Arial" size=3D"2"></f=
ont></span>&nbsp;</div>
<div><span class=3D"703545106-03052009"><font face=3D"Arial" size=3D"2">Bra=
cha Landau</font></span></div>
<div><span class=3D"703545106-03052009"></span>&nbsp;</div>
<div><span class=3D"703545106-03052009"><font face=3D"Arial" size=3D"2"></f=
ont></span>&nbsp;</div>
<div><span class=3D"703545106-03052009"><font face=3D"Arial" size=3D"2"></f=
ont></span>&nbsp;</div>
<div><span class=3D"703545106-03052009"><font face=3D"Arial" size=3D"2"></f=
ont></span>&nbsp;</div>
<div><span class=3D"703545106-03052009"><font face=3D"Arial" size=3D"2"></f=
ont></span>&nbsp;</div>
<div><span class=3D"703545106-03052009"><font face=3D"Arial" size=3D"2"></f=
ont></span>&nbsp;</div>
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

--_000_065A7D06F7D4E546A18E80E08D066E1811892DD86BILMA1ILNDSCOM_--
