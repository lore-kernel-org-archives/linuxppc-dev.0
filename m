Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id F25662BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Oct 2004 00:56:34 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Date: Fri, 29 Oct 2004 09:44:07 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B06DBA4@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Pantelis Antoniou" <panto@intracom.gr>,
	"Tom Rini" <trini@kernel.crashing.org>
Cc: Joakim Tjernlund <joakim.tjernlund@lumentis.se>,
	linuxppc-embedded@ozlabs.org
Subject: RE: Merge 8xx to Linus tree?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

One thing to look at...
On 8260 at least, I had to change use of request_irq in a PCI init
function to setup_irq()
Setup_irq is meant to be called before kmalloc works.

> -----Original Message-----
> From: linuxppc-embedded-bounces@ozlabs.org=20
> [mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of=20
> Pantelis Antoniou
> Sent: Friday, October 29, 2004 09:23
> To: Tom Rini
> Cc: Joakim Tjernlund; linuxppc-embedded@ozlabs.org
> Subject: Re: Merge 8xx to Linus tree?
>=20
>=20
> Tom Rini wrote:
>=20
> [snip]
>=20
> >In 2.6.10-rc1 release? No.  In linuxppc-2.5? Now, yes.  The changes=20
> >came from Randy Vinson, to make request_irq() /=20
> >openpic_hookup_cascade() calls become arch_initcalls() which=20
> fixed at=20
> >least some platforms.  I would guess 8xx will need something similar.
> >
> > =20
> >
> In linuxppc-2.5 yes.
>=20
> Just trying to catch up after my small period of absence...
>=20
> Regards
>=20
> Pantelis
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org=20
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
>=20
