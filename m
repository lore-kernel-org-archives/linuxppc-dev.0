Return-Path: <rwehbi@wirecom-tech.com>
Received: from fbsmtp.clm.net4all.ch (fbsmtp.net4all-dns.com [80.80.228.64])
	by ozlabs.org (Postfix) with ESMTP id 2D464DDE41
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Jul 2008 16:59:30 +1000 (EST)
Received: from smtp1.clm.net4all.ch (unknown [10.2.0.1])
	by fbsmtp.clm.net4all.ch (Postfix) with ESMTP id B31FE99DDE
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Jul 2008 08:36:48 +0200 (CEST)
Received: from wirecom-tech.com (unknown [212.99.18.146])
	by smtp1.clm.net4all.ch (Postfix) with ESMTP id D142460170
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Jul 2008 08:36:32 +0200 (CEST)
MIME-Version: 1.0
Content-Type: multipart/related; type="multipart/alternative";
	boundary="----_=_NextPart_001_01C8E320.3B488088"
Subject: linux boot sequence
Date: Fri, 11 Jul 2008 08:34:54 +0200
Message-ID: <D3C541E264C021479BFB60B3B790C0FB497014@etoilenoire.STARWARS.local>
From: "Rami WEHBI" <rwehbi@wirecom-tech.com>
To: <linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C8E320.3B488088
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C8E320.3B488088"


------_=_NextPart_002_01C8E320.3B488088
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi all,
=20
    I am using the ppc405 and I would like to know, how does linux on =
this architect detect the available memory size in details !!!
        is it a parameter passed to linux at startup by the boot loader =
??
        is it an automatic detection ?? what are the steps to accomplish =
this job then ???
=20
Best regards to all,
=20
Rami
=20



Rami WEHBI =09
Recherche & D=E9veloppement =09
T=E9l :	 +33 2 36 56 86 00=09
Fax :	 +33 2 36 56 86 01=09
www.wirecom-tech.com=09

  <http://www.wirecom-tech.com> =09

WIRECOM Technologies=20
135, Rue Jacques Charles
45166 Olivet
=09

  =09

  =09


------_=_NextPart_002_01C8E320.3B488088
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" =
"http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML xmlns=3D"http://www.w3.org/1999/xhtml"><HEAD><TITLE>signature =
e-mail</TITLE>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2900.3354" name=3DGENERATOR>
<STYLE type=3Dtext/css>BODY {
	FONT-SIZE: 10px; FONT-FAMILY: Verdana
}
DIV {
	FONT-SIZE: 10px; FONT-FAMILY: Verdana
}
TD {
	FONT-SIZE: 10px; COLOR: #737373; FONT-FAMILY: Verdana
}
TH {
	FONT-SIZE: 10px; COLOR: #737373; FONT-FAMILY: Verdana
}
A {
	COLOR: #737373; TEXT-DECORATION: none
}
A:hover {
	COLOR: #0076ba; TEXT-DECORATION: none
}
</STYLE>
</HEAD>
<BODY><FONT face=3DArial size=3D2></FONT>
<DIV><BR><SPAN class=3D777512906-11072008></SPAN><FONT =
face=3DArial><FONT=20
size=3D2>Hi&nbsp;all,</FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2></FONT></FONT>&nbsp;</DIV>
<DIV><FONT><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D777512906-11072008>&nbsp;&nbsp;&nbsp; </SPAN>I<SPAN=20
class=3D777512906-11072008> am using the ppc405 and I would like to =
know,=20
how&nbsp;does linux&nbsp;on this architect detect the available memory =
size in=20
details !!!</SPAN></FONT></FONT></FONT></DIV>
<DIV><FONT><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D777512906-11072008>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; is =
it a=20
parameter passed to linux at startup by the boot loader=20
??</SPAN></FONT></FONT></FONT></DIV>
<DIV><FONT><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D777512906-11072008>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; is =
it an=20
automatic detection ?? what are the steps to accomplish this job then=20
???</SPAN></FONT></FONT></FONT></DIV>
<DIV><FONT><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D777512906-11072008></SPAN></FONT></FONT></FONT>&nbsp;</DIV>
<DIV><FONT><FONT face=3DArial><FONT size=3D2><SPAN =
class=3D777512906-11072008>Best=20
regards to all,</SPAN></FONT></FONT></FONT></DIV>
<DIV><FONT><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D777512906-11072008></SPAN></FONT></FONT></FONT>&nbsp;</DIV>
<DIV><FONT><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D777512906-11072008>Rami</SPAN></FONT></FONT></FONT></DIV>
<DIV><FONT><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D777512906-11072008></SPAN></FONT></FONT></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT><BR><BR></DIV>
<TABLE cellSpacing=3D2 cellPadding=3D0 width=3D600 border=3D0>
  <TBODY>
  <TR>
    <TD><STRONG><FONT face=3D"Verdana, Arial, Helvetica, sans-serif"=20
      color=3D#0076ba size=3D2>Rami WEHBI </FONT></STRONG></TD></TR>
  <TR>
    <TD><STRONG><FONT face=3D"Verdana, Arial, Helvetica, sans-serif"=20
      color=3D#010202 size=3D2>Recherche &amp; =
D=E9veloppement</FONT></STRONG>=20
  </TD></TR></TBODY></TABLE>
<TABLE cellSpacing=3D2 cellPadding=3D0 width=3D600 border=3D0>
  <TBODY>
  <TR><FONT face=3D"Verdana, Arial, Helvetica, sans-serif" =
color=3D#737373 size=3D2>
    <TD width=3D60>T=E9l :</TD>
    <TD>+33 2 36 56 86 00</TD></FONT></TR>
  <TR><FONT face=3D"Verdana, Arial, Helvetica, sans-serif" =
color=3D#737373 size=3D2>
    <TD width=3D60>Fax :</TD>
    <TD>+33 2 36 56 86 01</TD></FONT></TR></TBODY></TABLE>
<TABLE cellSpacing=3D2 cellPadding=3D0 width=3D600 border=3D0>
  <TBODY>
  <TR>
    <TD><FONT face=3D"Verdana, Arial, Helvetica, sans-serif" size=3D2><A =

      title=3Dwww.wirecom-tech.com href=3D"http://www.wirecom-tech.com"=20
      target=3D_blank>www.wirecom-tech.com</A></FONT></TD></TR>
  <TR>
    <TD><BR><A title=3Dwww.wirecom-tech.com =
href=3D"http://www.wirecom-tech.com"=20
      target=3D_blank><IMG height=3D65=20
      alt=3D"WIRECOM&nbsp;Technologies, faites communiquer vos =
=E9nergies !"=20
      src=3D"cid:777512906@11072008-0622" width=3D204 border=3D0> =
</A></TD></TR>
  <TR>
    <TD><BR><FONT face=3D"Verdana, Arial, Helvetica, sans-serif" =
color=3D#737373=20
      size=3D1><STRONG>WIRECOM&nbsp;Technologies </STRONG><BR><FONT=20
      face=3D"Verdana, Arial, Helvetica, sans-serif" color=3D#737373 =
size=3D2>135, Rue=20
      Jacques Charles</FONT><BR><FONT=20
      face=3D"Verdana, Arial, Helvetica, sans-serif" color=3D#737373 =
size=3D2>45166=20
      Olivet</FONT><BR></FONT></TD></TR>
  <TR>
    <TD><BR><IMG height=3D65=20
      alt=3D"CONFIDENTIALITE : Ce message et les =E9ventuelles pi=E8ces =
attach=E9es sont confidentiels. Si vous n'=EAtes pas dans la liste des =
destinataires, veuillez informer l'exp=E9diteur imm=E9diatement et ne =
pas divulguer le contenu =E0 une tierce personne, ne pas l'utiliser pour =
quelque raison que ce soit, ne pas stocker ou copier l'information qu'il =
contient sur un quelconque =
support.&#13;&#10;&#9;&#9;&#9;&#9;&#9;&nbsp;&nbsp;&nbsp;&nbsp;CONFIDENTIA=
LITY : This e-mail and any attachments are confidential and may be =
privileged. If you are not a named recipient, please notify the sender =
immediately and do not disclose the contents to another person, use it =
for any purpose or store or copy the information in any medium."=20
      src=3D"cid:777512906@11072008-0629" width=3D602 border=3D0> =
</TD></TR>
  <TR>
    <TD><BR><IMG height=3D34=20
      alt=3D"WIRECOM&nbsp;Technologies s'engage pour l'environnement. =
N'imprimez ce mail que si n=E9cessaire"=20
      src=3D"cid:777512906@11072008-0630" width=3D558 border=3D0> =
</TD></TR></TBODY></TABLE>
<P></P></BODY></HTML>

------_=_NextPart_002_01C8E320.3B488088--

------_=_NextPart_001_01C8E320.3B488088
Content-Type: image/gif;
	name="logo_officiel_151.gif"
Content-Transfer-Encoding: base64
Content-ID: <777512906@11072008-0622>
Content-Description: logo_officiel_151.gif
Content-Location: logo_officiel_151.gif

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
dzgGQQAAOw==

------_=_NextPart_001_01C8E320.3B488088
Content-Type: image/gif;
	name="confidentialite.gif"
Content-Transfer-Encoding: base64
Content-ID: <777512906@11072008-0629>
Content-Description: confidentialite.gif
Content-Location: confidentialite.gif

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

------_=_NextPart_001_01C8E320.3B488088
Content-Type: image/gif;
	name="arbre-logo.gif"
Content-Transfer-Encoding: base64
Content-ID: <777512906@11072008-0630>
Content-Description: arbre-logo.gif
Content-Location: arbre-logo.gif

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
gRq4gRzYgR74gQYRBAA7

------_=_NextPart_001_01C8E320.3B488088--
