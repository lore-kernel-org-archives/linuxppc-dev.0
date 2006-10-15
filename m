Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id C214467C20
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Oct 2006 19:21:28 +1000 (EST)
Date: Sun, 15 Oct 2006 13:20:58 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: preempt crash in 2.6.18
Message-ID: <20061015132058.01c68605@localhost.localdomain>
In-Reply-To: <1160781278.4792.279.camel@localhost.localdomain>
References: <DCEAAC0833DD314AB0B58112AD99B93B07B397@ismail.innsys.innovsys.com>
	<20061014012105.6ca4ff05@localhost.localdomain>
	<1160781278.4792.279.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_sIBXqMBQCINz_j8NfK4hduy;
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Sig_sIBXqMBQCINz_j8NfK4hduy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 14 Oct 2006 09:14:38 +1000
Benjamin Herrenschmidt wrote:

> On Sat, 2006-10-14 at 01:21 +0400, Vitaly Bordug wrote:
> > On Fri, 13 Oct 2006 09:16:52 -0500
> > Rune Torgersen wrote:
> >=20
> > >=20
> > > This is from a Freescale 8265 running 2.6.18
> > > Anyone have any idea what this is and how to fix it?
> > >=20
> > Yes. Actually, I recall alike thing and used to fix with proper
> > spin-locking if the cascade PCI irq, which apparently does do_irq
> > that seems to confuse preempt counters.
> >=20
> > Just a pure guess.
>=20
> How so ? Cascades shouldn't do do_IRQ with the new irq code anyway
> unless this is still arch/ppc, they should do either __do_IRQ or
> better, generic_handle_irq().
>=20
To clarify - I was about __do_IRQ and arch/ppc.=20
Anyway, cascade for PCI is the first place I'd give a look.

--
Sincerely,

-Vitaly

--Sig_sIBXqMBQCINz_j8NfK4hduy
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFMf16uOg9JvQhSEsRAuMHAJ0YCPmAwEX4PagVgLZ8fIhJtSueCACeNdV8
FQkHvN7AOAnSjju7rgRMrHo=
=c2aH
-----END PGP SIGNATURE-----

--Sig_sIBXqMBQCINz_j8NfK4hduy--
