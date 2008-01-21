Return-Path: <mamsadegh@hotmail.com>
Received: from bay0-omc2-s34.bay0.hotmail.com (bay0-omc2-s34.bay0.hotmail.com
	[65.54.246.170]) by ozlabs.org (Postfix) with ESMTP id 93764DDDF4
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Jan 2008 18:36:59 +1100 (EST)
Message-ID: <BAY115-W17ECE16AB6FA79B2D4DBBDB23D0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_6cbc30b0-bc10-4a8a-8ebe-254415f3d8f3_"
From: Mohammad Sadegh Sadri <mamsadegh@hotmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Xilinx XPS_LL_TEMAC vs PLB_TEMAC
Date: Mon, 21 Jan 2008 07:36:58 +0000
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--_6cbc30b0-bc10-4a8a-8ebe-254415f3d8f3_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi All,

As you know Xilinx PLB TEMAC is a module which connects Hard TEMAC in Virte=
x-4 FX devices to PLB bus,
now, in the new release of EDK , EDK 9.2 Xilinx has added a new interface c=
ore , which is called XPS_LL_TEMAC and has a different structure than norma=
l PLB TEMAC. spacially it has some additional data transfer buses.=20

Now the question is,... is there any linux driver available for this new co=
re?

thanks


_________________________________________________________________


--_6cbc30b0-bc10-4a8a-8ebe-254415f3d8f3_
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
<body class=3D'hmmessage'>
Hi All,<br><br>As you know Xilinx PLB TEMAC is a module which connects Hard=
 TEMAC in Virtex-4 FX devices to PLB bus,<br>now, in the new release of EDK=
 , EDK 9.2 Xilinx has added a new interface core , which is called XPS_LL_T=
EMAC and has a different structure than normal PLB TEMAC. spacially it has =
some additional data transfer buses. <br><br>Now the question is,... is the=
re any linux driver available for this new core?<br><br>thanks<br><br><br /=
><hr /> <a href=3D'' target=3D'_new'></a></body>
</html>=

--_6cbc30b0-bc10-4a8a-8ebe-254415f3d8f3_--
