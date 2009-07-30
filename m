Return-Path: <ashish.kalra@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 37198B7BBA
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 31 Jul 2009 00:01:02 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1E72BDDD1C
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Jul 2009 00:00:54 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n6UE0kq7025896
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jul 2009 07:00:51 -0700 (MST)
Received: from zin33exm20.fsl.freescale.net (zin33exm20.ap.freescale.net
	[10.232.192.5])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n6UE10dT014684
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jul 2009 09:01:01 -0500 (CDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA111E.1FE629D0"
Subject: RE: [PATCH][sata_fsl] Defer non-ncq commands when ncq commands active
Date: Thu, 30 Jul 2009 19:28:12 +0530
Message-ID: <16444A0F3094A24C83EAB7836A12C63B032E5C@zin33exm20.fsl.freescale.net>
References: <Pine.WNT.4.64.0907292129310.4440@B00888-02.fsl.freescale.net>
	<4A70A78D.7070601@gmail.com>
	<16444A0F3094A24C83EAB7836A12C63B032E5A@zin33exm20.fsl.freescale.net>
	<E8D39D04-E4B6-4420-AD54-6A95BE35EB30@kernel.crashing.org>
From: "Kalra Ashish-B00888" <ashish.kalra@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org,
	Robert Hancock <hancockrwd@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA111E.1FE629D0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello Kumar,

>> > This doesn't look like it should change anything. sata_fsl_ops=20
>> inherits
>> > from sata_pmp_port_ops, which inherits from sata_port_ops, which=20
>> already
>> > sets qc_defer to ata_std_qc_defer.
>> Oh, yes. Actually this patch was for older kernels where there=20
>> inheritence was not there. As you mentioned, this patch is not=20
>> required now.
>>
>How old?  Should we be asking for this to be applied to some of the=20
>stable kernel series?

I believe that the inheritence stuff was added in 2.6.26, thus, this =
patch is
required for quite old kernels ( < 2.6.26 ).

Thanks,

Ashish


------_=_NextPart_001_01CA111E.1FE629D0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<HTML dir=3Dltr><HEAD><TITLE>Re: [PATCH][sata_fsl] Defer non-ncq =
commands when ncq commands active</TITLE>=0A=
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dunicode">=0A=
<META content=3D"MSHTML 6.00.2900.3562" name=3DGENERATOR></HEAD>=0A=
<BODY>=0A=
<DIV id=3DidOWAReplyText27244 dir=3Dltr>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 size=3D2>Hello =
Kumar,</FONT></DIV></DIV>=0A=
<DIV dir=3Dltr><BR><FONT size=3D2>&gt;&gt; &gt; This doesn't look like =
it should change anything. sata_fsl_ops&nbsp;<BR>&gt;&gt; =
inherits<BR>&gt;&gt; &gt; from sata_pmp_port_ops, which inherits from =
sata_port_ops, which&nbsp;<BR>&gt;&gt; already<BR>&gt;&gt; &gt; sets =
qc_defer to ata_std_qc_defer.<BR>&gt;&gt; Oh, yes. Actually this patch =
was for older kernels where there&nbsp;<BR>&gt;&gt; inheritence was not =
there. As you mentioned, this patch is not&nbsp;<BR>&gt;&gt; required =
now.<BR>&gt;&gt;<BR>&gt;How old?&nbsp; Should we be asking for this to =
be applied to some of the&nbsp;<BR>&gt;stable kernel series?<BR><BR>I =
believe that the inheritence stuff was added in 2.6.26, thus, this patch =
is</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT size=3D2>required for quite old kernels ( &lt; =
2.6.26 ).</FONT></DIV>=0A=
<P><FONT size=3D2>Thanks,</FONT></P>=0A=
<P><FONT size=3D2>Ashish</P></FONT></BODY></HTML>
------_=_NextPart_001_01CA111E.1FE629D0--
