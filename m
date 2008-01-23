Return-Path: <mike.koss@ngc.com>
Received: from xmrm0101.northgrum.com (xmrm0101.northgrum.com
	[155.104.240.104]) by ozlabs.org (Postfix) with ESMTP id 0AD3ADDE25
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Jan 2008 00:43:17 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C85DC5.E717D002"
Subject: RE: Xilinx XPS_LL_TEMAC vs PLB_TEMAC
Date: Wed, 23 Jan 2008 07:43:14 -0600
Message-ID: <EDAE140DF1B2FC42B5867C22CA0B333F0A5959@XMBIL132.northgrum.com>
In-Reply-To: <BAY115-W415137ADEA0BE4A33D2BAEB23F0@phx.gbl>
References: <BAY115-W17ECE16AB6FA79B2D4DBBDB23D0@phx.gbl><440abda90801202354l5a0ce4caq382af5991e36f775@mail.gmail.com>
	<BAY115-W344A18C61627B3075C6281B23D0@phx.gbl>
	<EDAE140DF1B2FC42B5867C22CA0B333F0A5952@XMBIL132.northgrum.com>
	<BAY115-W415137ADEA0BE4A33D2BAEB23F0@phx.gbl>
From: "Koss, Mike (Mission Systems)" <mike.koss@ngc.com>
To: "Mohammad Sadegh Sadri" <mamsadegh@hotmail.com>,
	"David Baird" <dhbaird@gmail.com>, <linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C85DC5.E717D002
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Actually, with the MPMC3 the XPS_LL_TEMAC still can directly connect to
the MPMC. You set one of the ports' type to SDMA and it instantiates
what is similar to the old CDMAC.=20

________________________________

From: Mohammad Sadegh Sadri [mailto:mamsadegh@hotmail.com]=20
Sent: Wednesday, January 23, 2008 2:36 AM
To: Koss, Mike (Mission Systems); David Baird;
linuxppc-embedded@ozlabs.org
Subject: RE: Xilinx XPS_LL_TEMAC vs PLB_TEMAC


Hi

Well, As you know, we now need a PLB version, XPS_LL_TEMAC is connected
to PLB not MPMC2...yes I remember those days of Xilinx GSRD and MPMC2
however it seems that the current architecture has slight changes.=20

about the git repository of Xilinx, Although I do not believe on it,
I'll give it a try...thanks for info.

well, what about Grant Likely... and his git tree?



________________________________

	Subject: RE: Xilinx XPS_LL_TEMAC vs PLB_TEMAC
	Date: Mon, 21 Jan 2008 11:44:14 -0600
	From: mike.koss@ngc.com
	To: mamsadegh@hotmail.com; dhbaird@gmail.com;
linuxppc-embedded@ozlabs.org
=09
=09
	In case anyone is interested, I'm currently working on an
almost-kernel-ready version that will be self-contained based on the
LL-DMA version (the native MPMC port, not the PLB). It's based upon the
old adapter from MontaVista, that I originally ported to 2.6 and the
MPMC2. Unfortunately, it won't be ready for another few weeks since I'm
working on hardware images currently.
	=20
	-- Mike
=09
=09
________________________________

	From: Mohammad Sadegh Sadri [mailto:mamsadegh@hotmail.com]=20
	Sent: Monday, January 21, 2008 3:54 AM
	To: David Baird; linuxppc-embedded@ozlabs.org
	Subject: RE: Xilinx XPS_LL_TEMAC vs PLB_TEMAC
=09
=09
	thanks for you reply david,
=09
	As far as I know the Linux driver for Xilinx PLB TEMAC was two
parts : 1- adapter.c and 2- the rest of the driver files
=09
	Only adapter.c was really a linux related file and the rest of
the files were Xilinx generic driver code for PLB TEMAC.
=09
	correct?
=09
	then now, I know EDK 9.2 generates the needed Linux support
package and needed related files, so if this is the case can we use
these files as the needed driver in our linux kernel?
=09
	by the way, i did never hear about this git repository
before...can you describe us, where is it and how we can access it and
which projects are now hosted by it?
=09
=09
	thanks
=09
=09
	> Date: Mon, 21 Jan 2008 00:54:30 -0700
	> From: dhbaird@gmail.com
	> To: mamsadegh@hotmail.com
	> Subject: Re: Xilinx XPS_LL_TEMAC vs PLB_TEMAC
	>=20
	> On Jan 21, 2008 12:36 AM, Mohammad Sadegh Sadri
<mamsadegh@hotmail.com> wrote:
	> > As you know Xilinx PLB TEMAC is a module which connects Hard
TEMAC in
	> > Virtex-4 FX devices to PLB bus,
	> > now, in the new release of EDK , EDK 9.2 Xilinx has added a
new interface
	> > core , which is called XPS_LL_TEMAC and has a different
structure than
	> > normal PLB TEMAC. spacially it has some additional data
transfer buses.
	> >
	> > Now the question is,... is there any linux driver available
for this new
	> > core?
	>=20
	> Yes there is, but I had to use the git sources at:
	>=20
	> git.xilinx.com
=09
=09
________________________________

	<http://>=20


________________________________


------_=_NextPart_001_01C85DC5.E717D002
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

<META content=3D"MSHTML 6.00.2900.3243" name=3DGENERATOR></HEAD>
<BODY class=3Dhmmessage>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D578424013-23012008><FONT =
face=3DArial=20
color=3D#0000ff>Actually, with the MPMC3&nbsp;the =
XPS_LL_TEMAC&nbsp;still can=20
directly connect to the MPMC. You set one of the ports' type&nbsp;to =
SDMA and it=20
instantiates what is similar to the old CDMAC. </FONT></SPAN></DIV><BR>
<DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
<HR tabIndex=3D-1>
<FONT face=3DTahoma><B>From:</B> Mohammad Sadegh Sadri=20
[mailto:mamsadegh@hotmail.com] <BR><B>Sent:</B> Wednesday, January 23, =
2008 2:36=20
AM<BR><B>To:</B> Koss, Mike (Mission Systems); David Baird;=20
linuxppc-embedded@ozlabs.org<BR><B>Subject:</B> RE: Xilinx XPS_LL_TEMAC =
vs=20
PLB_TEMAC<BR></FONT><BR></DIV>
<DIV></DIV>Hi<BR><BR>Well, As you know, we now need a PLB version, =
XPS_LL_TEMAC=20
is connected to PLB not MPMC2...yes I remember those days of Xilinx GSRD =
and=20
MPMC2 however it seems that the current architecture has slight changes. =

<BR><BR>about the git repository of Xilinx, Although I do not believe on =
it,=20
I'll give it a try...thanks for info.<BR><BR>well, what about Grant =
Likely...=20
and his git tree?<BR><BR>
<BLOCKQUOTE>
  <HR>
  Subject: RE: Xilinx XPS_LL_TEMAC vs PLB_TEMAC<BR>Date: Mon, 21 Jan =
2008=20
  11:44:14 -0600<BR>From: mike.koss@ngc.com<BR>To: =
mamsadegh@hotmail.com;=20
  dhbaird@gmail.com; linuxppc-embedded@ozlabs.org<BR><BR>
  <META content=3D"Microsoft SafeHTML" name=3DGenerator>
  <STYLE>.ExternalClass .EC_hmmessage P {
	PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; =
PADDING-TOP: 0px
}
.ExternalClass EC_BODY.hmmessage {
	FONT-SIZE: 10pt; FONT-FAMILY: Tahoma
}
</STYLE>

  <DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff><SPAN=20
  class=3DEC_188023817-21012008>In case anyone is interested, I'm =
currently=20
  working on an almost-kernel-ready version that will be self-contained =
based on=20
  the LL-DMA version (the native MPMC port, not the PLB). It's based =
upon the=20
  old adapter from MontaVista, that I originally ported to 2.6 and the =
MPMC2.=20
  Unfortunately, it won't be ready for another few weeks since I'm =
working on=20
  hardware images currently.</SPAN></FONT></DIV>
  <DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff><SPAN=20
  class=3DEC_188023817-21012008></SPAN></FONT>&nbsp;</DIV>
  <DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff><SPAN=20
  class=3DEC_188023817-21012008>-- Mike</SPAN></FONT></DIV><FONT =
face=3DArial=20
  color=3D#0000ff></FONT><BR>
  <DIV class=3DEC_OutlookMessageHeader lang=3Den-us dir=3Dltr =
align=3Dleft>
  <HR>
  <FONT face=3DTahoma><B>From:</B> Mohammad Sadegh Sadri=20
  [mailto:mamsadegh@hotmail.com] <BR><B>Sent:</B> Monday, January 21, =
2008 3:54=20
  AM<BR><B>To:</B> David Baird; =
linuxppc-embedded@ozlabs.org<BR><B>Subject:</B>=20
  RE: Xilinx XPS_LL_TEMAC vs PLB_TEMAC<BR></FONT><BR></DIV>
  <DIV></DIV>thanks for you reply david,<BR><BR>As far as I know the =
Linux=20
  driver for Xilinx PLB TEMAC was two parts : 1- adapter.c and 2- the =
rest of=20
  the driver files<BR><BR>Only adapter.c was really a linux related file =
and the=20
  rest of the files were Xilinx generic driver code for PLB=20
  TEMAC.<BR><BR>correct?<BR><BR>then now, I know EDK 9.2 generates the =
needed=20
  Linux support package and needed related files, so if this is the case =
can we=20
  use these files as the needed driver in our linux kernel?<BR><BR>by =
the way, i=20
  did never hear about this git repository before...can you describe us, =
where=20
  is it and how we can access it and which projects are now hosted by=20
  it?<BR><BR><BR>thanks<BR><BR><BR>&gt; Date: Mon, 21 Jan 2008 00:54:30=20
  -0700<BR>&gt; From: dhbaird@gmail.com<BR>&gt; To:=20
  mamsadegh@hotmail.com<BR>&gt; Subject: Re: Xilinx XPS_LL_TEMAC vs=20
  PLB_TEMAC<BR>&gt; <BR>&gt; On Jan 21, 2008 12:36 AM, Mohammad Sadegh =
Sadri=20
  &lt;mamsadegh@hotmail.com&gt; wrote:<BR>&gt; &gt; As you know Xilinx =
PLB TEMAC=20
  is a module which connects Hard TEMAC in<BR>&gt; &gt; Virtex-4 FX =
devices to=20
  PLB bus,<BR>&gt; &gt; now, in the new release of EDK , EDK 9.2 Xilinx =
has=20
  added a new interface<BR>&gt; &gt; core , which is called XPS_LL_TEMAC =
and has=20
  a different structure than<BR>&gt; &gt; normal PLB TEMAC. spacially it =
has=20
  some additional data transfer buses.<BR>&gt; &gt;<BR>&gt; &gt; Now the =

  question is,... is there any linux driver available for this =
new<BR>&gt; &gt;=20
  core?<BR>&gt; <BR>&gt; Yes there is, but I had to use the git sources=20
  at:<BR>&gt; <BR>&gt; git.xilinx.com<BR><BR>
  <HR>
  <A href=3D"http://" target=3D_blank></A></BLOCKQUOTE><BR>
<HR>
<A href=3D"" target=3D_new></A></BODY></HTML>

------_=_NextPart_001_01C85DC5.E717D002--
