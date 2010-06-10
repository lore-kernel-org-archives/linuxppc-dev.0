Return-Path: <kpada84@hotmail.com>
Received: from bay0-omc4-s9.bay0.hotmail.com (bay0-omc4-s9.bay0.hotmail.com
	[65.54.190.211]) by ozlabs.org (Postfix) with ESMTP id D7E2BB7D92
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Jun 2010 09:12:36 +1000 (EST)
Message-ID: <BAY152-w58B66B551376FF621F6E4DBCD80@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_6919af1d-ae8b-44ea-ada9-3c88bd9999b6_"
From: kostas padarnitsas <kpada84@hotmail.com>
To: <skrishnakar@gmail.com>
Subject: RE: Port Linux to ML510
Date: Fri, 11 Jun 2010 02:12:33 +0300
In-Reply-To: <AANLkTimQNPb0WAvAk6mNAsy25k0OZ482EwLCD0wlukvl@mail.gmail.com>
References: <BAY152-w7029D1872C3896BB5E40DBCD70@phx.gbl>,
	<AANLkTimQNPb0WAvAk6mNAsy25k0OZ482EwLCD0wlukvl@mail.gmail.com>
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_6919af1d-ae8b-44ea-ada9-3c88bd9999b6_
Content-Type: text/plain; charset="iso-8859-7"
Content-Transfer-Encoding: quoted-printable


Hi Srikant=2C
Thanks for your help. I checked the driver versions and they seem ok. The p=
roblem is that when I download the linux image the program counter is not s=
et to the address of boot sector of linux kernel=2C so linux doesn't boot. =
On the other hand with the ML507 everything works perfectly. Any idea??
Thanks in advance=2CKostas

Date: Thu=2C 10 Jun 2010 12:34:56 +0530
Subject: Re: Port Linux to ML510
From: skrishnakar@gmail.com
To: kpada84@hotmail.com
CC: linuxppc-dev@lists.ozlabs.org

Hi kostas=2C

You need to verify that the driver version of serial and Ethernet (probably=
 X-LLTEMAC) provided in the virtex440.dts matches version used in kernel. L=
ook for "compatible =3D <version>" in the drivers. You can probably use EDK=
 11.2 as it is the latest from Xilinx.=20


Have you generated your own DTS and Bitstream (download.bit) files ?

If not then you should look for suitable download.bit for you kernel.

-Srikant

2010/6/10 kostas padarnitsas <kpada84@hotmail.com>






Hello=2C
I am trying to port Linux to PowerPC on the ML510 Xilinx board. I am using =
EDK 10.1.3 to build the hardware and also device tree generator and the lin=
ux kernel from xilinx git. I followed the tutorial from http://xilinx.wikid=
ot.com/powerpc-linux but I have no output. I have attached my .mhs file and=
 the .dts.  Any ideas what may cause this problem because I did the same th=
ing with ML507 and it was working perfectly?

Thanks in advance=2CKostas 		 	   		 =20
Your E-mail and More On-the-Go. Get Windows Live Hotmail Free. Sign up now.


_______________________________________________

Linuxppc-dev mailing list

Linuxppc-dev@lists.ozlabs.org

https://lists.ozlabs.org/listinfo/linuxppc-dev


--=20
"The Good You Do=2C The Best You GET"


Regards
Srikanth Krishnakar
**********************
 		 	   		 =20
_________________________________________________________________
Hotmail: Free=2C trusted and rich email service.
https://signup.live.com/signup.aspx?id=3D60969=

--_6919af1d-ae8b-44ea-ada9-3c88bd9999b6_
Content-Type: text/html; charset="iso-8859-7"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Verdana
}
--></style>
</head>
<body class=3D'hmmessage'>
Hi Srikant=2C<div><br></div><div>Thanks for your help. I checked the driver=
 versions and they seem ok. The problem is that when I download the linux i=
mage the program counter is not set to the address of boot sector of linux =
kernel=2C so linux doesn't boot. On the other hand with the ML507 everythin=
g works perfectly. Any idea??</div><div><br></div><div>Thanks in advance=2C=
</div><div>Kostas<br><br><hr id=3D"stopSpelling">Date: Thu=2C 10 Jun 2010 1=
2:34:56 +0530<br>Subject: Re: Port Linux to ML510<br>From: skrishnakar@gmai=
l.com<br>To: kpada84@hotmail.com<br>CC: linuxppc-dev@lists.ozlabs.org<br><b=
r>Hi kostas=2C<br><br>You need to verify that the driver version of serial =
and Ethernet (probably X-LLTEMAC) provided in the virtex440.dts matches ver=
sion used in kernel. Look for "compatible =3D &lt=3Bversion&gt=3B" in the d=
rivers. You can probably use EDK 11.2 as it is the latest from Xilinx. <br>
<br>Have you generated your own DTS and Bitstream (download.bit) files ?<br=
><br>If not then you should look for suitable download.bit for you kernel.<=
br><br>-Srikant<br><br><div class=3D"ecxgmail_quote">2010/6/10 kostas padar=
nitsas <span dir=3D"ltr">&lt=3B<a href=3D"mailto:kpada84@hotmail.com">kpada=
84@hotmail.com</a>&gt=3B</span><br>
<blockquote class=3D"ecxgmail_quote" style=3D"padding-left:1ex">



<div>
Hello=2C<div><br></div><div>I am trying to port Linux to PowerPC on the ML5=
10 Xilinx board. I am using EDK 10.1.3 to build the hardware and also devic=
e tree generator and the linux kernel from xilinx git. I followed the tutor=
ial from&nbsp=3B<a href=3D"http://xilinx.wikidot.com/powerpc-linux">http://=
xilinx.wikidot.com/powerpc-linux</a>&nbsp=3Bbut I have no output. I have at=
tached my .mhs file and the .dts. &nbsp=3BAny ideas what may cause this pro=
blem because I did the same thing with ML507 and it was working perfectly?<=
/div>
<div><br></div><div>Thanks in advance=2C</div><div>Kostas</div><font color=
=3D"#888888"> 		 	   		  </font><br><div class=3D"ecxhm"><hr>Your E-mail an=
d More On-the-Go. Get Windows Live Hotmail Free. <a href=3D"https://signup.=
live.com/signup.aspx?id=3D60969">Sign up now.</a></div>
</div>
<br>_______________________________________________<br>
Linuxppc-dev mailing list<br>
<a href=3D"mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.ozlabs.=
org</a><br>
<a href=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev">https://lists.oz=
labs.org/listinfo/linuxppc-dev</a><br></blockquote></div><br><br clear=3D"a=
ll"><br>-- <br>"The Good You Do=2C The Best You GET"<br>
<br>Regards<br>Srikanth Krishnakar<br>**********************<br></div> 		 	=
   		  <br /><hr />Hotmail: Free=2C trusted and rich email service. <a href=
=3D'https://signup.live.com/signup.aspx?id=3D60969' target=3D'_new'>Get it =
now.</a></body>
</html>=

--_6919af1d-ae8b-44ea-ada9-3c88bd9999b6_--
