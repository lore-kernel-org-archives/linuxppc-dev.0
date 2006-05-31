Return-Path: <Behre.Frederik@litef.de>
Received: from proxy03.litef.de (mail.litef.de [193.101.168.104])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B749F67A66
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 May 2006 17:50:04 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: AW: MPC8270 on Microsys PM827 Kernel 2.6 Oops: kernel access of bad
	area, sig: 11 [#1]
Date: Wed, 31 May 2006 09:49:58 +0200
Message-ID: <CC692F5386B0AA47A62B7484A7CA2B6D02C4CFCC@frmx1.litef.de>
From: "Behre, Frederik - LT" <Behre.Frederik@litef.de>
To: <wd@denx.de>
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

Thanks for answer me.=20
I want to install Xenomai on this mpc8270. Therefor I need 2.6.14 =
,because I need the adeos patch.=20

Thanks for helping me

Freddy



-----Urspr=FCngliche Nachricht-----
Von: wd@denx.de [mailto:wd@denx.de]=20
Gesendet: Dienstag, 30. Mai 2006 22:44
An: Behre, Frederik - LT
Cc: linuxppc-embedded@ozlabs.org
Betreff: Re: MPC8270 on Microsys PM827 Kernel 2.6 Oops: kernel access of =
bad area, sig: 11 [#1]

In message <CC692F5386B0AA47A62B7484A7CA2B6D02B52CB0@frmx1.litef.de> you =
wrote:
>=20
> I compile my kernel with
> pm82x_deconfig and PCI disabled.
...
> MPC8260 Reset Status: External Soft, External Hard

Why do you use pm82x_deconfig with a MPC8260  processor?  You  should =
use pm826_deconfig instead.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de =
That's the thing about people who think  they  hate  computers.  What =
they really hate is lousy programmers.
- Larry Niven and Jerry Pournelle in "Oath of Fealty"
