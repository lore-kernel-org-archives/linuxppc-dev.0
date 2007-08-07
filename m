Return-Path: <michael@ellerman.id.au>
Subject: Re: Please pull powerpc.git merge branch
From: Michael Ellerman <michael@ellerman.id.au>
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
In-Reply-To: <1186455451.2163.3.camel@localhost.localdomain>
References: <18099.1109.83340.915328@cargo.ozlabs.ibm.com>
	<46B96294322F7D458F9648B60E15112C7A98ED@zch01exm26.fsl.freescale.net>
	<FCAE5E05-7F25-436F-963B-B757765D343A@kernel.crashing.org>
	<1186448777.19257.0.camel@concordia.ozlabs.ibm.com>
	<1186455451.2163.3.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-X3qaGH8AQitvwdei9HuO"
Date: Tue, 07 Aug 2007 13:18:35 +1000
Message-Id: <1186456715.19257.16.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Zhang Wei-r63237 <Wei.Zhang@freescale.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-X3qaGH8AQitvwdei9HuO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-08-07 at 10:57 +0800, Zang Roy-r61911 wrote:
> On Tue, 2007-08-07 at 09:06, Michael Ellerman wrote:
> > On Mon, 2007-08-06 at 08:57 -0500, Kumar Gala wrote:
> > > On Aug 6, 2007, at 12:57 AM, Zhang Wei-r63237 wrote:
> > >=20
> > > > Hi, Paul,
> > > >
> > > > How about following patches?
> > > >
> > > > [PATCH 1/2] Add sysdev/pci_quirks.c file into PowerPC
> > architecture =20
> > > > with
> > > > ULI chip quirk functions.
> > > > URL:
> > http://ozlabs.org/pipermail/linuxppc-dev/2007-August/040363.html
> > > > [PATCH 2/2] Remove ULI chip quirks functions from MPC8641HPCN and
> > > > MPC8544DS boards.
> > > > URL:
> > http://ozlabs.org/pipermail/linuxppc-dev/2007-August/040364.html
> > > >
> > > > [PATCH 1/3] Add a new member name to structure irq_host
> > > > URL:
> > http://ozlabs.org/pipermail/linuxppc-dev/2007-July/039896.html
> > > > [PATCH 2/3] Add irq host name for all powerpc interrupt
> > controllors.
> > > > URL:
> > http://ozlabs.org/pipermail/linuxppc-dev/2007-July/039897.html
> > > > [PATCH 3/3] Add irq debugfs and virq_mapping for getting the virq
> > > > URL:
> > http://ozlabs.org/pipermail/linuxppc-dev/2007-July/039895.html
> > >=20
> > > These patches aren't fixing any bugs and would be for 2.6.24 at
> > this =20
> > > point.
> >=20
> > And I reworked them and posted new versions.
> Where are the new versions?
> I missed them?

On the list, I though I cc'ed you but I guess I forgot :)

http://patchwork.ozlabs.org/linuxppc/patch?q=3Dellerman&id=3D12612
http://patchwork.ozlabs.org/linuxppc/patch?q=3Dellerman&id=3D12613
http://patchwork.ozlabs.org/linuxppc/patch?q=3Dellerman&id=3D12614
http://patchwork.ozlabs.org/linuxppc/patch?q=3Dellerman&id=3D12615
http://patchwork.ozlabs.org/linuxppc/patch?q=3Dellerman&id=3D12616

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-X3qaGH8AQitvwdei9HuO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGt+SLdSjSd0sB4dIRAufEAJ9F8GShgEBQT5y5CJGIY7aV7ot++ACgjv9B
cC1GkEUc/tZ9HSvpcu9QbcQ=
=LQHT
-----END PGP SIGNATURE-----

--=-X3qaGH8AQitvwdei9HuO--
