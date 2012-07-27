Return-Path: <blavoie@zygo.com>
Received: from mail1.bemta7.messagelabs.com (mail1.bemta7.messagelabs.com
 [216.82.255.50]) by ozlabs.org (Postfix) with ESMTP id 2390C2C008D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jul 2012 03:28:02 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----_=_NextPart_001_01CD6C1D.24D7E933"
Subject: MPC8308RDB spi not working
Date: Fri, 27 Jul 2012 13:27:48 -0400
Message-ID: <5C67A60B8796CB4EB72EBE6E3A8027FB016206AA@MIDEXC01.zygo.com>
From: "Lavoie, Bruce" <blavoie@zygo.com>
To: <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CD6C1D.24D7E933
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All,

=20

I'm working on a MPC8308RDB evaluation board using the Freescale LTIB
2.6.29 kernel that ships with the board.  The board support package as
it comes does not support the SPI interface.  I've been working with the
spi_mpc83xx.c file and I found an open firmware patch, which appears to
be working at a glance.  I'm trying to get the spidev.c user interface
working, but it's not invoking the probe function.  I'm tracing thru
with GDB and see that the spi_driver is getting initialized correctly
prior to calling driver_register, but for some reason "probe" is just
not getting invoked.

=20

I'm hoping someone has run into this problem and could provide some
assistance.  I've exhausted my google searching and I'm not able to find
a solution.

=20

Any help is greatly appreciated.

=20

Thanks

=20


CONFIDENTIALITY NOTICE: This e-mail transmission and any documents accompa=
nying this e-mail transmission may contain information from Zygo Corporati=
on which is confidential privileged and/or controlled by export regulation=
s.  The information is intended only for the use of the intended recipient=
.  No confidentiality or privilege is waived or lost by any transmission e=
rrors. If you are not the intended recipient, you are hereby notified that=
 any use, disclosure, copying, distribution or the taking of any action in=
 reliance on the contents of this e-mail information is strictly prohibite=
d, and the documents should be returned to Zygo Corporation immediately.  =
If you have received this e-mail in error please notify us immediately by =
e-mail at the address set forth above.
------_=_NextPart_001_01CD6C1D.24D7E933
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-mic=
rosoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word=
" xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"ht=
tp://www.w3.org/TR/REC-html40"><head><meta http-equiv=3DContent-Type conte=
nt=3D"text/html; charset=3Dus-ascii"><meta name=3DGenerator content=3D"Mic=
rosoft Word 14 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
=09{font-family:Calibri;
=09panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
=09{margin:0in;
=09margin-bottom:.0001pt;
=09font-size:11.0pt;
=09font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
=09{mso-style-priority:99;
=09color:blue;
=09text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
=09{mso-style-priority:99;
=09color:purple;
=09text-decoration:underline;}
span.EmailStyle17
=09{mso-style-type:personal-compose;
=09font-family:"Calibri","sans-serif";
=09color:windowtext;}
.MsoChpDefault
=09{mso-style-type:export-only;
=09font-family:"Calibri","sans-serif";}
@page WordSection1
=09{size:8.5in 11.0in;
=09margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
=09{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3Dblue vl=
ink=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal>Hi All,<o:p></=
o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>I&#=
8217;m working on a MPC8308RDB evaluation board using the Freescale LTIB 2=
.6.29 kernel that ships with the board.&nbsp; The board support package as=
 it comes does not support the SPI interface.&nbsp; I&#8217;ve been workin=
g with the spi_mpc83xx.c file and I found an open firmware patch, which ap=
pears to be working at a glance.&nbsp; I&#8217;m trying to get the spidev.=
c user interface working, but it&#8217;s not invoking the probe function.&=
nbsp; I&#8217;m tracing thru with GDB and see that the spi_driver is getti=
ng initialized correctly prior to calling driver_register, but for some re=
ason &#8220;probe&#8221; is just not getting invoked.<o:p></o:p></p><p cla=
ss=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>I&#8217;m hoping =
someone has run into this problem and could provide some assistance.&nbsp;=
 I&#8217;ve exhausted my google searching and I&#8217;m not able to find a=
 solution.<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p clas=
s=3DMsoNormal>Any help is greatly appreciated.<o:p></o:p></p><p class=3DMs=
oNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Thanks<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p></div><br clear=3D"both">
CONFIDENTIALITY NOTICE: This e-mail transmission and any documents accompa=
nying this e-mail transmission may contain information from Zygo Corporati=
on which is confidential privileged and/or controlled by export regulation=
s.  The information is intended only for the use of the intended recipient=
.  No confidentiality or privilege is waived or lost by any transmission e=
rrors. If you are not the intended recipient, you are hereby notified that=
 any use, disclosure, copying, distribution or the taking of any action in=
 reliance on the contents of this e-mail information is strictly prohibite=
d, and the documents should be returned to Zygo Corporation immediately.  =
If you have received this e-mail in error please notify us immediately by =
e-mail at the address set forth above.<BR>
</body></html>
------_=_NextPart_001_01CD6C1D.24D7E933--
