Return-Path: <mike.koss@ngc.com>
Received: from xmrm0101.northgrum.com (xmrm0101.northgrum.com
	[155.104.240.104]) by ozlabs.org (Postfix) with ESMTP id 3CD69DDDEA
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 16 Mar 2008 15:12:32 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8871B.F2E5644D"
Subject: RE: Compile time error, compiling Xilinx Linux 2.6 for XPS LLTEMAC
Date: Sat, 15 Mar 2008 23:12:27 -0500
Message-ID: <EDAE140DF1B2FC42B5867C22CA0B333FA99D2F@XMBIL132.northgrum.com>
In-Reply-To: <BAY115-W186EA84A950C17657AD8D9B20B0@phx.gbl>
References: <BAY115-W186EA84A950C17657AD8D9B20B0@phx.gbl>
From: "Koss, Mike (Mission Systems)" <mike.koss@ngc.com>
To: "Mohammad Sadegh Sadri" <mamsadegh@hotmail.com>,
	<linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C8871B.F2E5644D
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

That interrupt is defined if you build a xps_ll_temac with the
xps_ll_fifo interface. Since you already stated that you're using the
mpmc, I'm going to assume that you have it connected to a SDMA
controller on the mpmc. As such the driver should be looking for that
definition, and not the FIFO interrupt. I don't have your version of the
virtex_devices.c to have a reference as to how the platform device is
being defined, so hopefully either Stephen N can chime in w/ more
information, or point me to the version of the virtex_devices.c that
you're using and I can try to provide some more assistance.
=20
-- Mike

________________________________

From: Mohammad Sadegh Sadri [mailto:mamsadegh@hotmail.com]=20
Sent: Saturday, March 15, 2008 4:31 AM
To: linuxppc-embedded@ozlabs.org
Subject: Compile time error, compiling Xilinx Linux 2.6 for XPS LLTEMAC


All,

that should be a small problem, and i think that its solution should be
simple,

I generate a base system using EDK 9.2.02 , the base system contains
XPS_LL_TEMAC , MPMC and other components,
I generate the software libraries and copy xparameters file into proper
kernel folder. I configure that kernel and add kernel support for
XPS_LL_TEMAC.

while doing make I encounter this error:

arch/ppc/syslib/virtex_devices.c:455: error:
'XPAR_LLTEMAC_0_LLINK_CONNECTED_FIFO_INTR' undeclared here (not in a
function)

I think that this definition should be available in xparameters_ml403.h
file but i see that there is no such definition.=20
I added a dummy definition for myself there to complete kernel
compilation, don't know the correct value for it of course.

thanks



________________________________

Access your files from anywhere with Windows Live SkyDrive! Sign up now
and get 5GB of space FREE! <http://g.msn.ca/ca55/209> =20

------_=_NextPart_001_01C8871B.F2E5644D
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<STYLE>.hmmessage P {
	PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: =
0px; PADDING-TOP: 0px
}
BODY.hmmessage {
	FONT-SIZE: 10pt; FONT-FAMILY: Tahoma
}
</STYLE>

<META content=3D"MSHTML 6.00.2900.3268" name=3DGENERATOR></HEAD>
<BODY class=3Dhmmessage>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D488120904-16032008><FONT =
face=3DArial=20
color=3D#0000ff>That interrupt is defined if you build a xps_ll_temac =
with the=20
xps_ll_fifo interface. Since you already stated that you're using the =
mpmc, I'm=20
going to assume that you have it connected to a SDMA controller on the =
mpmc. As=20
such the driver should be looking for that definition, and not the FIFO=20
interrupt. I don't have your version of the virtex_devices.c to have a =
reference=20
as to how the platform device is being defined, so hopefully either =
Stephen N=20
can chime in w/ more information, or point me to the version of the=20
virtex_devices.c that you're using and I can try to provide some more=20
assistance.</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D488120904-16032008><FONT =
face=3DArial=20
color=3D#0000ff></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D488120904-16032008><FONT =
face=3DArial=20
color=3D#0000ff>-- Mike</FONT></SPAN></DIV><BR>
<DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
<HR tabIndex=3D-1>
<FONT face=3DTahoma><B>From:</B> Mohammad Sadegh Sadri=20
[mailto:mamsadegh@hotmail.com] <BR><B>Sent:</B> Saturday, March 15, 2008 =
4:31=20
AM<BR><B>To:</B> linuxppc-embedded@ozlabs.org<BR><B>Subject:</B> Compile =
time=20
error, compiling Xilinx Linux 2.6 for XPS LLTEMAC<BR></FONT><BR></DIV>
<DIV></DIV>All,<BR><BR>that should be a small problem, and i think that =
its=20
solution should be simple,<BR><BR>I generate a base system using EDK =
9.2.02 ,=20
the base system contains XPS_LL_TEMAC , MPMC and other components,<BR>I =
generate=20
the software libraries and copy xparameters file into proper kernel =
folder. I=20
configure that kernel and add kernel support for =
XPS_LL_TEMAC.<BR><BR>while=20
doing make I encounter this =
error:<BR><BR>arch/ppc/syslib/virtex_devices.c:455:=20
error: 'XPAR_LLTEMAC_0_LLINK_CONNECTED_FIFO_INTR' undeclared here (not =
in a=20
function)<BR><BR>I think that this definition should be available in=20
xparameters_ml403.h file but i see that there is no such definition. =
<BR>I added=20
a dummy definition for myself there to complete kernel compilation, =
don't know=20
the correct value for it of course.<BR><BR>thanks<BR><BR><BR>
<HR>
Access your files from anywhere with Windows Live SkyDrive! <A=20
href=3D"http://g.msn.ca/ca55/209" target=3D_new>Sign up now and get 5GB =
of space=20
FREE!</A> </BODY></HTML>

------_=_NextPart_001_01C8871B.F2E5644D--
