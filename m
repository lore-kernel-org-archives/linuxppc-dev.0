Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id A7D5D67B5D
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Jun 2005 00:35:38 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Fri, 10 Jun 2005 09:23:31 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B8593BC@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "linuxppc-dev list" <linuxppc-dev@ozlabs.org>
Subject: RE: boot time scheduling hile atomic
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Any patch forthcomming soon?=20

> -----Original Message-----
> From: linuxppc-dev-bounces@ozlabs.org=20
> [mailto:linuxppc-dev-bounces@ozlabs.org] On Behalf Of=20
> Benjamin Herrenschmidt
> Sent: Wednesday, March 16, 2005 16:29
> To: Takeharu KATO
> Cc: linuxppc-dev list
> Subject: Re: boot time scheduling hile atomic
>=20
> On Wed, 2005-03-16 at 23:07 +0900, Takeharu KATO wrote:
> > Hi Benjamin:
> >=20
> > I can not figure out why my previous patch is more preferable than
> > later one.
> > Could you explain the reason of that please.
>=20
> There may be other kernel bits calling syscall, it sounds saner to
> always make sure we don't reschedule when in atomic (though=20
> it's dubious
> that it's allowed to do syscalls in atomic regions, let's be safe
> there).
>=20
> In fact, we are thinking about consolidating the syscall=20
> return path and
> the normal irq return path like we did on ppc64.
>=20
> Ben.
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>=20
>=20
