Return-Path: <huubeikens@hotmail.com>
Received: from bay0-omc2-s7.bay0.hotmail.com (bay0-omc2-s7.bay0.hotmail.com
	[65.54.246.143]) by ozlabs.org (Postfix) with ESMTP id 74EBCDDF52
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 May 2008 21:03:17 +1000 (EST)
Message-ID: <BAY122-W428F4FD4AED8DAED5968A1DABF0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_8a6f6790-5aee-4ecc-ae3d-a4920ab76f4a_"
From: Huub Eikens <huubeikens@hotmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: USB Host Controller driver for the MPC8270 processor
Date: Thu, 29 May 2008 11:03:16 +0000
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--_8a6f6790-5aee-4ecc-ae3d-a4920ab76f4a_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,
=20
I am in need of a USB Host Controller device for the Freescale MPC8270 for =
the 2.4 linux kernel (ELDK 3.1.1). On internet I found one, but this is onl=
y for version 2.6:
http://cpm2usb.sourceforge.net/

I have a few options:
1. backport this driver to 2.4.25 kernel. I would like to know if this is f=
easible or not. I get the feeling that this will take a lot of time.
2. upgrade my kernel to 2.6.x. This is not preferable for me since I depend=
 on sw modules writen by external partners. If I upgrade, I really really n=
eed to be sure that this driver
is stable and reliable.
3. Use an external USB Host Controller. Can anyone advise me on which contr=
oller to choose that runs stable and reliable on the 2.4.25 kernel (ELDK 3.=
1.1)?

Kind regards,
=20
Huub Eikens

_________________________________________________________________
De leukste online filmpjes vind je op MSN Video!
http://video.msn.com/video.aspx?mkt=3Dnl-nl=

--_8a6f6790-5aee-4ecc-ae3d-a4920ab76f4a_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
FONT-SIZE: 10pt;
FONT-FAMILY:Tahoma
}
</style>
</head>
<body class=3D'hmmessage'><div style=3D"text-align: left;"><pre>Hi,<br> <br=
>I am in need of a USB Host Controller device for the Freescale MPC8270 for=
 the 2.4 linux kernel (ELDK 3.1.1). On internet I found one, but this is on=
ly for version 2.6:<br><a href=3D"http://cpm2usb.sourceforge.net/" target=
=3D"_blank">http://cpm2usb.sourceforge.net/</a><br><br>I have a few options=
:<br>1. backport this driver to 2.4.25 kernel. I would like to know if this=
 is feasible or not. I get the feeling that this will take a lot of time.<b=
r>2. upgrade my kernel to 2.6.x. This is not preferable for me since I depe=
nd on sw modules writen by external partners. If I upgrade, I really really=
 need to be sure that this driver<br>is stable and reliable.<br>3. Use an e=
xternal USB Host Controller. Can anyone advise me on which controller to ch=
oose that runs stable and reliable on the 2.4.25 kernel (ELDK 3.1.1)?<br><b=
r>Kind regards,<br> <br>Huub Eikens<br></pre></div><br /><hr />Chat met al =
je vrienden. <a href=3D'https://www.invite2messenger.nl/Default.aspx' targe=
t=3D'_new'>Voeg ze nu allemaal toe aan Messenger!</a></body>
</html>=

--_8a6f6790-5aee-4ecc-ae3d-a4920ab76f4a_--
