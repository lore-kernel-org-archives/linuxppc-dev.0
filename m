Return-Path: <John.Linn@xilinx.com>
Received: from outbound9-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id C49D7DDE06
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 May 2008 03:17:56 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8C0E6.C0E69100"
Subject: RE: Cross toolchain for ppc405 (virtex-4)
Date: Wed, 28 May 2008 11:16:41 -0600
References: <17515929.post@talk.nabble.com>
From: "John Linn" <John.Linn@xilinx.com>
To: "Mirek23" <miroslaw.dach@psi.ch>,
	<linuxppc-embedded@ozlabs.org>
Message-Id: <20080528171751.D545CBD8071@mail116-sin.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------_=_NextPart_001_01C8C0E6.C0E69100
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Miroslaw,

I'm not sure on what version of gcc and glibc it's using, but I have been u=
sing ELDK 4.1 from denx.com. There are newer versions.

Thanks,
John =




-----Original Message-----
From: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org on behalf=
 of Mirek23
Sent: Wed 5/28/2008 9:54 AM
To: linuxppc-embedded@ozlabs.org
Subject: Cross toolchain for ppc405 (virtex-4)
 =


Hi All,

I am using for some time the crosstool tool-chain (crosstool-0.43) for the
ppc405 of my virtex-4.
It seems to be that the crosstool was not updated for awhile but the glibc
and gcc compiler has changed a bit meanwhile.

The latest working configuration to build the toolchain for ppc405 is
gcc-4.1.0-glibc-2.3.6.dat
Does any body has tried to adapt the crosstools to use for example glibc 2.=
7
?

Another alternative would be to use another tool than crosstool. Could
somebody recommend something which can refer to newer version of gcc and
glibc .

Best Regards

Miroslaw Dach =


-- =

View this message in context: http://www.nabble.com/Cross-toolchain-for-ppc=
405-%28virtex-4%29-tp17515929p17515929.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded




This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.


------_=_NextPart_001_01C8C0E6.C0E69100
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Diso-8859-=
1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version 6.5.7652.24"=
>
<TITLE>RE: Cross toolchain for ppc405 (virtex-4)</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hi Miroslaw,<BR>
<BR>
I'm not sure on what version of gcc and glibc it's using, but I have been u=
sing ELDK 4.1 from denx.com. There are newer versions.<BR>
<BR>
Thanks,<BR>
John<BR>
<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org on behalf=
 of Mirek23<BR>
Sent: Wed 5/28/2008 9:54 AM<BR>
To: linuxppc-embedded@ozlabs.org<BR>
Subject: Cross toolchain for ppc405 (virtex-4)<BR>
<BR>
<BR>
Hi All,<BR>
<BR>
I am using for some time the crosstool tool-chain (crosstool-0.43) for the<=
BR>
ppc405 of my virtex-4.<BR>
It seems to be that the crosstool was not updated for awhile but the glibc<=
BR>
and gcc compiler has changed a bit meanwhile.<BR>
<BR>
The latest working configuration to build the toolchain for ppc405 is<BR>
gcc-4.1.0-glibc-2.3.6.dat<BR>
Does any body has tried to adapt the crosstools to use for example glibc 2.=
7<BR>
?<BR>
<BR>
Another alternative would be to use another tool than crosstool. Could<BR>
somebody recommend something which can refer to newer version of gcc and<BR=
>
glibc .<BR>
<BR>
Best Regards<BR>
<BR>
Miroslaw Dach<BR>
<BR>
--<BR>
View this message in context: <A HREF=3D"http://www.nabble.com/Cross-toolch=
ain-for-ppc405-%28virtex-4%29-tp17515929p17515929.html">http://www.nabble.c=
om/Cross-toolchain-for-ppc405-%28virtex-4%29-tp17515929p17515929.html</A><B=
R>
Sent from the linuxppc-embedded mailing list archive at Nabble.com.<BR>
<BR>
_______________________________________________<BR>
Linuxppc-embedded mailing list<BR>
Linuxppc-embedded@ozlabs.org<BR>
<A HREF=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://o=
zlabs.org/mailman/listinfo/linuxppc-embedded</A><BR>
<BR>
<BR>
</FONT>
</P>

<br clear=3Dall> This email and any attachments are intended for the sole u=
se of the named recipient(s) and contain(s) confidential information that m=
ay be proprietary, privileged or copyrighted under applicable law. If you a=
re not the intended recipient, do not read, copy, or forward this email mes=
sage or any attachments. Delete this email message and any attachments imme=
diately.
</BODY>
</HTML>


------_=_NextPart_001_01C8C0E6.C0E69100--
