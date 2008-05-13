Return-Path: <Marc.Howard@kla-tencor.com>
Received: from ca1mail04.kla-tencor.com (mailout04.kla-tencor.com
	[192.146.1.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B4B48DE0C6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 May 2008 04:31:38 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8B521.FAD32472"
Subject: RE: mmap problem in device driver and application program.
Date: Tue, 13 May 2008 10:51:31 -0700
Message-ID: <921B6E79C3E18642BFFC1C8633C430DBCBDDBE@CA1EXCLV07.adcorp.kla-tencor.com>
In-Reply-To: <BAY138-W368A781D323F0E5E4D0BF3B2CF0@phx.gbl>
References: <BAY138-W55519F961B3A01D0B8A167B2D00@phx.gbl><1210266109.3755.8.camel@localhost.localdomain><BAY138-W36C7249F532D111A1DC508B2D00@phx.gbl>
	<1210366552.3755.21.camel@localhost.localdomain>
	<BAY138-W368A781D323F0E5E4D0BF3B2CF0@phx.gbl>
From: "Howard, Marc" <Marc.Howard@kla-tencor.com>
To: "MingLiu" <eemingliu@hotmail.com>, "Dave Cogley" <dcogley@uslinc.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8B521.FAD32472
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

=20

	Dear Dave,
=09
	> If you are using memory that is not under the kernel's memory =
management
	> you will need to use something other than remap_pfn_range.
	>=20
=09
	Happenly and unfortunately we are using the memory space out of the =
control from the kernel. We have 2GB memory on the board and only 64(or =
32) MB is reserved for the kernel. The rest large space is for the data =
buffering or LUT use. In my question, the LUT memory is located in the =
rest part rather than the kernel memory area.=20
	=20
	Any more suggestion on how to mmap this LUT area? Any idea will be =
valuable for a beginner like me. Thanks in advance.=20
	=20
	BR
	Ming
=09
=09
________________________________

	=A1=B0=C6=DF=BC=FE=CE=E4=C6=F7=A3=AC=C6=DF=D6=D6=CD=EA=C3=C0=A1=B1 =
=C1=A2=BF=CC=CC=E5=D1=E9=A3=A1 <http://get.live.cn>  =20

I have a similar setup where the upper 64MB are reserved for hardware.  =
The mmap implementation in my device driver works just fine using =
io_remap_page_range().
=20
Marc Howard
=20

------_=_NextPart_001_01C8B521.FAD32472
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dgb2312">
<STYLE>.hmmessage P {
	PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: =
0px; PADDING-TOP: 0px
}
BODY.hmmessage {
	FONT-SIZE: 9pt; FONT-FAMILY: Tahoma
}
</STYLE>

<META content=3D"MSHTML 6.00.2800.1609" name=3DGENERATOR></HEAD>
<BODY class=3Dhmmessage>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D554054917-13052008><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<BLOCKQUOTE=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px =
solid; MARGIN-RIGHT: 0px">
  <DIV></DIV>
  <DIV>Dear Dave,<BR><BR>&gt; If you are using memory that is not under =
the=20
  kernel's memory management<BR>&gt; you will need to use something =
other than=20
  remap_pfn_range.<BR>&gt; <BR><BR>Happenly and unfortunately we are =
using the=20
  memory space out of the control from the kernel. We have 2GB memory on =
the=20
  board and only 64(or 32) MB is reserved for the kernel. The rest large =
space=20
  is for the data buffering or LUT use. In my question, the LUT memory =
is=20
  located in the rest part rather than the kernel memory area. =
<BR>&nbsp;<BR>Any=20
  more suggestion on how to mmap this LUT area? Any idea will be =
valuable for a=20
  beginner like me. Thanks in advance. =
<BR>&nbsp;<BR>BR<BR>Ming<BR><BR></DIV>
  <DIV>
  <HR>
  </DIV>
  =
<DIV>=A1=B0=C6=DF=BC=FE=CE=E4=C6=F7=A3=AC=C6=DF=D6=D6=CD=EA=C3=C0=A1=B1 =
<A href=3D"http://get.live.cn" =
target=3D_new>=C1=A2=BF=CC=CC=E5=D1=E9=A3=A1</A>&nbsp;<SPAN=20
  class=3D554054917-13052008><FONT face=3DArial color=3D#0000ff=20
  size=3D2>&nbsp;</FONT></SPAN></DIV></BLOCKQUOTE>
<DIV><SPAN class=3D554054917-13052008><FONT face=3DArial size=3D2>I have =
a similar=20
setup where the upper 64MB are reserved for hardware.&nbsp; The mmap=20
implementation in my device driver works just fine using=20
io_remap_page_range().</FONT></SPAN></DIV>
<DIV><SPAN class=3D554054917-13052008></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D554054917-13052008><FONT face=3DArial size=3D2>Marc=20
Howard</FONT></SPAN></DIV>
<DIV><SPAN class=3D554054917-13052008>&nbsp;</SPAN></DIV></BODY></HTML>

------_=_NextPart_001_01C8B521.FAD32472--
