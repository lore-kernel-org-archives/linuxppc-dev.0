Return-Path: <mamsadegh@hotmail.com>
Received: from bay0-omc2-s40.bay0.hotmail.com (bay0-omc2-s40.bay0.hotmail.com
	[65.54.246.176]) by ozlabs.org (Postfix) with ESMTP id DFC54DDE05
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Mar 2008 19:30:32 +1100 (EST)
Message-ID: <BAY115-W186EA84A950C17657AD8D9B20B0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_279286ab-02cb-48de-a113-87df9c4ac880_"
From: Mohammad Sadegh Sadri <mamsadegh@hotmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Compile time error, compiling Xilinx Linux 2.6 for XPS LLTEMAC
Date: Sat, 15 Mar 2008 08:30:31 +0000
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

--_279286ab-02cb-48de-a113-87df9c4ac880_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


All,

that should be a small problem, and i think that its solution should be sim=
ple,

I generate a base system using EDK 9.2.02 , the base system contains XPS_LL=
_TEMAC , MPMC and other components,
I generate the software libraries and copy xparameters file into proper ker=
nel folder. I configure that kernel and add kernel support for XPS_LL_TEMAC=
.

while doing make I encounter this error:

arch/ppc/syslib/virtex_devices.c:455: error: 'XPAR_LLTEMAC_0_LLINK_CONNECTE=
D_FIFO_INTR' undeclared here (not in a function)

I think that this definition should be available in xparameters_ml403.h fil=
e but i see that there is no such definition.=20
I added a dummy definition for myself there to complete kernel compilation,=
 don't know the correct value for it of course.

thanks


_________________________________________________________________
Create a handy button so your friends can add U to their buddy list. Try it=
 now!
http://g.msn.ca/ca55/211=

--_279286ab-02cb-48de-a113-87df9c4ac880_
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
All,<br><br>that should be a small problem, and i think that its solution s=
hould be simple,<br><br>I generate a base system using EDK 9.2.02 , the bas=
e system contains XPS_LL_TEMAC , MPMC and other components,<br>I generate t=
he software libraries and copy xparameters file into proper kernel folder. =
I configure that kernel and add kernel support for XPS_LL_TEMAC.<br><br>whi=
le doing make I encounter this error:<br><br>arch/ppc/syslib/virtex_devices=
.c:455: error: 'XPAR_LLTEMAC_0_LLINK_CONNECTED_FIFO_INTR' undeclared here (=
not in a function)<br><br>I think that this definition should be available =
in xparameters_ml403.h file but i see that there is no such definition. <br=
>I added a dummy definition for myself there to complete kernel compilation=
, don't know the correct value for it of course.<br><br>thanks<br><br><br /=
><hr />Access your files from anywhere with Windows Live SkyDrive!  <a href=
=3D'http://g.msn.ca/ca55/209' target=3D'_new'>Sign up now and get 5GB of sp=
ace FREE!</a></body>
</html>=

--_279286ab-02cb-48de-a113-87df9c4ac880_--
