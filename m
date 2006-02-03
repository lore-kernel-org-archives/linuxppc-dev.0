Return-Path: <Marc.Bodmer@securiton.ch>
Received: from mrp.swissptt.ch (outmail2.swisscom.com [138.190.3.29])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "outmail2.swisscom.com",
	Issuer "VeriSign Trust Network" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 62DE268A31
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Feb 2006 00:59:53 +1100 (EST)
Received: from stnzolav1.securiton.int ([10.101.10.36])
	by mrp.swissptt.ch with ESMTP id k13DxfRI002392
	for <linuxppc-embedded@ozlabs.org>; Fri, 3 Feb 2006 14:59:42 +0100 (MET)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: AW: How to cross-build OpenSSL shared library 
Date: Fri, 3 Feb 2006 14:59:41 +0100
Message-ID: <5DDC68DD3569BB4D92D660326A9C095301728954@stnzolex1.securiton.int>
From: <Marc.Bodmer@securiton.ch>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Thanks Wolfgang, I will check it.
I guess I will need to "spy" there for many other packages.

kind regards
Marc

-----Urspr=FCngliche Nachricht-----
Von: wd@denx.de [mailto:wd@denx.de]
Gesendet: Freitag, 3. Februar 2006 14:44
An: Bodmer Marc, Securiton, ESS
Cc: linuxppc-embedded@ozlabs.org
Betreff: Re: How to cross-build OpenSSL shared library=0D


In message=
 <5DDC68DD3569BB4D92D660326A9C095301728952@stnzolex1.securiton.int> you=
 wrote:
>=0D
> I am using ELDK (3.1.1) and there is a built OpenSSL as shared library
> available.
> Does anybody know about how they managed to build this shared library?

The DULG describes in detail how to rebuild all ELDK  RPMs  from  the
sources.  Just  download  and  install  the  Source RPM and check the
commands in the spec file.

Best regards,

Wolfgang Denk

--=0D
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Perl already has an IDE.  It's called Unix.
                      -- Tom Christiansen in 375bd509@cs.colorado.edu

<html>
<body>
<font face =3D "arial" size =3D "1">
---------------------------------------------------------------------------=
------------------------------
This e-mail is confidential and may contain privileged information.
It is intended only for the addressees. If you have received this
e-mail in error, kindly notify us immediately by telephone or e-mail
and delete the message from your system.
---------------------------------------------------------------------------=
------------------------------
</font>
</body>
</html>
