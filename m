Return-Path: <mustafa.cayir@bte.mam.gov.tr>
Received: from itri.bte.mam.gov.tr (itri.bte.mam.gov.tr [193.140.75.15])
	by ozlabs.org (Postfix) with SMTP id 41C03DDEA3
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 31 Aug 2007 15:39:00 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7EB91.39ECD44B"
Subject: RE: STK5200 pci_enable_device problem
Date: Fri, 31 Aug 2007 08:38:32 +0300
Message-ID: <7B9A8FF57DBB524190E98CABF6E56F070B9287@itri.bte.mam.gov.tr>
References: <20070829233106.9766C24044@gemini.denx.de>
	<46D68BA6.4020102@sympatec.com>
From: "Mustafa Cayir" <mustafa.cayir@bte.mam.gov.tr>
To: "Oliver Rutsch" <orutsch@sympatec.com>,
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

------_=_NextPart_001_01C7EB91.39ECD44B
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello Oliver,

My problems continue, could you summarize your steps to bring up the =
board?
which u-boot version is used?
how build tqm5200.dts file?
did you test pci bus?

Thanks.


-----Original Message-----
From: =
linuxppc-embedded-bounces+mustafa.cayir=3Dbte.mam.gov.tr@ozlabs.org on =
behalf of Oliver Rutsch
Sent: Thu 8/30/2007 12:19 PM
To: linuxppc-embedded@ozlabs.org
Subject: Re: STK5200 pci_enable_device problem
=20
Hi again,

>=20
> As mentioned above, with arch/powerpc you always need a  device  tree
> blob.
>=20
> Best regards,
>=20
> Wolfgang Denk
>=20

Thanks, Wolfang, now it's booting fine!
I've updated u-boot to the newest git version, builded the device tree=20
file and now everything's working.

Bye,

--=20
Dipl. Ing. Oliver Rutsch
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded


------_=_NextPart_001_01C7EB91.39ECD44B
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3DISO-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7638.1">
<TITLE>RE: STK5200 pci_enable_device problem</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hello Oliver,<BR>
<BR>
My problems continue, could you summarize your steps to bring up the =
board?<BR>
which u-boot version is used?<BR>
how build tqm5200.dts file?<BR>
did you test pci bus?<BR>
<BR>
Thanks.<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: =
linuxppc-embedded-bounces+mustafa.cayir=3Dbte.mam.gov.tr@ozlabs.org on =
behalf of Oliver Rutsch<BR>
Sent: Thu 8/30/2007 12:19 PM<BR>
To: linuxppc-embedded@ozlabs.org<BR>
Subject: Re: STK5200 pci_enable_device problem<BR>
<BR>
Hi again,<BR>
<BR>
&gt;<BR>
&gt; As mentioned above, with arch/powerpc you always need a&nbsp; =
device&nbsp; tree<BR>
&gt; blob.<BR>
&gt;<BR>
&gt; Best regards,<BR>
&gt;<BR>
&gt; Wolfgang Denk<BR>
&gt;<BR>
<BR>
Thanks, Wolfang, now it's booting fine!<BR>
I've updated u-boot to the newest git version, builded the device =
tree<BR>
file and now everything's working.<BR>
<BR>
Bye,<BR>
<BR>
--<BR>
Dipl. Ing. Oliver Rutsch<BR>
_______________________________________________<BR>
Linuxppc-embedded mailing list<BR>
Linuxppc-embedded@ozlabs.org<BR>
<A =
HREF=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://oz=
labs.org/mailman/listinfo/linuxppc-embedded</A><BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C7EB91.39ECD44B--
