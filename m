Return-Path: <mustafa.cayir@bte.mam.gov.tr>
Received: from itri.bte.mam.gov.tr (www.bte.mam.gov.tr [193.140.75.15])
	by ozlabs.org (Postfix) with SMTP id CA5F3DDF82
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Aug 2007 18:51:14 +1000 (EST)
Subject: RE: STK5200 pci_enable_device problem
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7E950.94E88F00"
Date: Tue, 28 Aug 2007 11:51:10 +0300
Message-ID: <7B9A8FF57DBB524190E98CABF6E56F070B9283@itri.bte.mam.gov.tr>
References: <20070827191419.9A9CE24044@gemini.denx.de>
From: "Mustafa Cayir" <mustafa.cayir@bte.mam.gov.tr>
To: "Wolfgang Denk" <wd@denx.de>
Cc: linuxppc-embedded@ozlabs.org
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

------_=_NextPart_001_01C7E950.94E88F00
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

i build Linux-2.6.22-gbcfc8d37 kernel lastest kernel from denx git for =
the board (STK5200 with TQM5200-AB).
ELDK 4.1 version is used.

make mrproper
export ARCH=3Dpowerpc
make tqm5200_defconfig
make uImage

It hangs on after  following line
  Uncompressing Kernel Image ... OK

Our u-boot version : U-Boot 1.1.3 (Apr  7 2005 - 14:42:37)

Any idea will be appreciated.

Regards.

done
Bytes transferred =3D 1454056 (162fe8 hex)
## Booting image at 00200000 ...
   Image Name:   Linux-2.6.22-gbcfc8d37
   Created:      2007-08-28  19:41:27 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1453992 Bytes =3D  1.4 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK




-----Original Message-----
From: Wolfgang Denk [mailto:wd@denx.de]
Sent: Mon 8/27/2007 10:14 PM
To: Mustafa Cayir
Cc: Oliver Rutsch; linuxppc-embedded@ozlabs.org
Subject: Re: STK5200 pci_enable_device problem
=20
In message <7B9A8FF57DBB524190E98CABF6E56F070B927E@itri.bte.mam.gov.tr> =
you wrote:
>=20
> i use 2.4.25 kernel and eldk 3.1.1 on TQM5200 board. i tried denx =
2.6.19
> kernel to port on TQM5200 but i couldn't.
> Did you port 2.6 kernel on TQM5200? Did pci device start working
> succesfully after porting 2.6 kernel to TQM5200 board.

Current top-of-tree in our git repo has been tested with a Intel
EEPRO100 network card in the ST5200's PCI slot. It's working.

Best regards,

Wolfgang Denk

--=20
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Unsichtbar macht sich die Dummheit, indem sie immer  gr=F6=DFere  =
Ausma=DFe
annimmt.                             -- Bertold Brecht: Der Tui-Roman


------_=_NextPart_001_01C7E950.94E88F00
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

<P><FONT SIZE=3D2>Hi,<BR>
<BR>
i build Linux-2.6.22-gbcfc8d37 kernel lastest kernel from denx git for =
the board (STK5200 with TQM5200-AB).<BR>
ELDK 4.1 version is used.<BR>
<BR>
make mrproper<BR>
export ARCH=3Dpowerpc<BR>
make tqm5200_defconfig<BR>
make uImage<BR>
<BR>
It hangs on after&nbsp; following line<BR>
&nbsp; Uncompressing Kernel Image ... OK<BR>
<BR>
Our u-boot version : U-Boot 1.1.3 (Apr&nbsp; 7 2005 - 14:42:37)<BR>
<BR>
Any idea will be appreciated.<BR>
<BR>
Regards.<BR>
<BR>
done<BR>
Bytes transferred =3D 1454056 (162fe8 hex)<BR>
## Booting image at 00200000 ...<BR>
&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-2.6.22-gbcfc8d37<BR>
&nbsp;&nbsp; Created:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2007-08-28&nbsp; =
19:41:27 UTC<BR>
&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip =
compressed)<BR>
&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 1453992 Bytes =3D&nbsp; 1.4 =
MB<BR>
&nbsp;&nbsp; Load Address: 00000000<BR>
&nbsp;&nbsp; Entry Point:&nbsp; 00000000<BR>
&nbsp;&nbsp; Verifying Checksum ... OK<BR>
&nbsp;&nbsp; Uncompressing Kernel Image ... OK<BR>
<BR>
<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: Wolfgang Denk [<A =
HREF=3D"mailto:wd@denx.de">mailto:wd@denx.de</A>]<BR>
Sent: Mon 8/27/2007 10:14 PM<BR>
To: Mustafa Cayir<BR>
Cc: Oliver Rutsch; linuxppc-embedded@ozlabs.org<BR>
Subject: Re: STK5200 pci_enable_device problem<BR>
<BR>
In message =
&lt;7B9A8FF57DBB524190E98CABF6E56F070B927E@itri.bte.mam.gov.tr&gt; you =
wrote:<BR>
&gt;<BR>
&gt; i use 2.4.25 kernel and eldk 3.1.1 on TQM5200 board. i tried denx =
2.6.19<BR>
&gt; kernel to port on TQM5200 but i couldn't.<BR>
&gt; Did you port 2.6 kernel on TQM5200? Did pci device start =
working<BR>
&gt; succesfully after porting 2.6 kernel to TQM5200 board.<BR>
<BR>
Current top-of-tree in our git repo has been tested with a Intel<BR>
EEPRO100 network card in the ST5200's PCI slot. It's working.<BR>
<BR>
Best regards,<BR>
<BR>
Wolfgang Denk<BR>
<BR>
--<BR>
DENX Software Engineering GmbH,&nbsp;&nbsp;&nbsp;&nbsp; MD: Wolfgang =
Denk &amp; Detlev Zundel<BR>
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, =
Germany<BR>
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: =
wd@denx.de<BR>
Unsichtbar macht sich die Dummheit, indem sie immer&nbsp; =
gr=F6=DFere&nbsp; Ausma=DFe<BR>
annimmt.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -- Bertold Brecht: Der Tui-Roman<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C7E950.94E88F00--
