Return-Path: <michael@ellerman.id.au>
Subject: RE: [PATCH 4/6] ehea: header files
From: Michael Ellerman <michael@ellerman.id.au>
To: Christoph Raisch <RAISCH@de.ibm.com>
In-Reply-To: <OF8C6BA147.30EE53F8-ONC12571CB.003C7748-C12571CB.003CBAA4@de.ibm.com>
References: <OF8C6BA147.30EE53F8-ONC12571CB.003C7748-C12571CB.003CBAA4@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-C70jxZ6nTIR1cf7UISPn"
Date: Wed, 16 Aug 2006 10:58:35 +1000
Message-Id: <1155689915.26911.12.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Thomas Q Klein <tklein@de.ibm.com>, "Jenkins,
	Clive" <Clive.Jenkins@xerox.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-C70jxZ6nTIR1cf7UISPn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-08-15 at 13:07 +0200, Christoph Raisch wrote:
>=20
> "Jenkins, Clive" wrote on 15.08.2006 12:53:05:
>=20
> > > > You mean the eHEA has its own concept of page size? Separate from
> > the
> > > > page size used by the MMU?
> > > >
> > >
> > > yes, the eHEA currently supports only 4K pages for queues
> >
> > In that case, I suggest use the kernel's page size, but add a
> > compile-time
> > check, and quit with an error message if driver does not support it.
>=20
> eHEA does support other page sizes than 4k, but the HW interface expects =
to
> see 4k pages
> The adaption is done in the device driver, therefore we have a seperate 4=
k
> define.

Fair enough. You seem to only use it in drivers/net/ehea/ehea_qmr.c, if
so put the definition in there, that way someone is less likely to use
the EHEA_PAGESIZE definition where they really need PAGE_SIZE.

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-C70jxZ6nTIR1cf7UISPn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBE4m27dSjSd0sB4dIRAjJoAKCYSuXQcxeK2D8QexOog2psXm/5AACdF9fl
k8KV682WSg2uHhJ8396+34o=
=23RL
-----END PGP SIGNATURE-----

--=-C70jxZ6nTIR1cf7UISPn--
