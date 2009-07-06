Return-Path: <fkan@amcc.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 05C4EB707C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  7 Jul 2009 03:10:57 +1000 (EST)
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.90])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 0F9A1DDD0B
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Jul 2009 03:10:55 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C9FE5A.CAD0C073"
Subject: RE: ppc405ex + gigabit ethernet
Date: Mon, 6 Jul 2009 09:56:11 -0700
Message-ID: <2B3B2AA816369A4E87D7BE63EC9D2F260615A364@SDCEXCHANGE01.ad.amcc.com>
References: <e35801cc0906300658q45d5ea00ub939ba73185efd72@mail.gmail.com><COL107-W41E84129BE81739BC96295B22E0@phx.gbl><579B119545DAEF4689C8FBEEFEC5793F01D4FF01A2D0@ATLMBX.verint.corp.verintsystems.com>
	<e35801cc0907030209y2a4bd50s7d12cf75341e3536@mail.gmail.com>
From: "Feng Kan" <fkan@amcc.com>
To: "Lada Podivin" <lada.podivin@gmail.com>,
	"Cote, Sylvain" <Sylvain.Cote@verint.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C9FE5A.CAD0C073
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Lada:

Please contact support@amcc.com for additional help for the coalescing =
patch.

Feng Kan
AMCC Software


-----Original Message-----
From: linuxppc-dev-bounces+fkan=3Damcc.com@lists.ozlabs.org on behalf of =
Lada Podivin
Sent: Fri 7/3/2009 2:09 AM
To: Cote, Sylvain
Cc: linuxppc-dev@ozlabs.org
Subject: Re: ppc405ex + gigabit ethernet
=20
Hi Sylvain,

the interrupt coalescing sounds like good idea - I'm surprised this
feature is missing in the original ibm_newemac driver. You wrote you
had got this optimisation directly from AMCC. Is it part of any
framework? I'm just wondering how one can obtain it. I tried to find
any suitable patch but with no success - the old friend Google didn't
help this time :)

Thank you very much!
Lada
_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@lists.ozlabs.org
https://lists.ozlabs.org/listinfo/linuxppc-dev


------_=_NextPart_001_01C9FE5A.CAD0C073
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7653.38">
<TITLE>RE: ppc405ex + gigabit ethernet</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hi Lada:<BR>
<BR>
Please contact support@amcc.com for additional help for the coalescing =
patch.<BR>
<BR>
Feng Kan<BR>
AMCC Software<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: linuxppc-dev-bounces+fkan=3Damcc.com@lists.ozlabs.org on behalf of =
Lada Podivin<BR>
Sent: Fri 7/3/2009 2:09 AM<BR>
To: Cote, Sylvain<BR>
Cc: linuxppc-dev@ozlabs.org<BR>
Subject: Re: ppc405ex + gigabit ethernet<BR>
<BR>
Hi Sylvain,<BR>
<BR>
the interrupt coalescing sounds like good idea - I'm surprised this<BR>
feature is missing in the original ibm_newemac driver. You wrote you<BR>
had got this optimisation directly from AMCC. Is it part of any<BR>
framework? I'm just wondering how one can obtain it. I tried to find<BR>
any suitable patch but with no success - the old friend Google =
didn't<BR>
help this time :)<BR>
<BR>
Thank you very much!<BR>
Lada<BR>
_______________________________________________<BR>
Linuxppc-dev mailing list<BR>
Linuxppc-dev@lists.ozlabs.org<BR>
<A =
HREF=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev">https://lists.ozl=
abs.org/listinfo/linuxppc-dev</A><BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C9FE5A.CAD0C073--
