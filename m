Return-Path: <dgibson@ozlabs.org>
Date: Wed, 12 Mar 2008 09:40:48 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: OF compatible MTD platform RAM driver ?
Message-ID: <20080311224048.GA7642@localhost.localdomain>
References: <200803101606.39184.laurentp@cse-semaphore.com>
	<DCEAAC0833DD314AB0B58112AD99B93B0418505E@ismail.innsys.innovsys.com>
	<20080311004545.GI11559@localhost.localdomain>
	<200803111139.12667.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
In-Reply-To: <200803111139.12667.laurentp@cse-semaphore.com>
Cc: ben@simtec.co.uk, linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2008 at 11:39:08AM +0100, Laurent Pinchart wrote:
> On Tuesday 11 March 2008 01:45, David Gibson wrote:
> > On Mon, Mar 10, 2008 at 12:00:22PM -0500, Rune Torgersen wrote:
> > > linuxppc-dev-bounces+runet=3Dinnovsys.com@ozlabs.org wrote:
[snip]
> > > We ran ito the same issue.
> > > We did option 3, as it was efinetly the easiest,
> >
> > I think this is the best option in principle.
>=20
> I'll implement that and post a patch after completing the ppc-to-powerpc=
=20
> migration.
>=20
> > > here is the sram entry in our dts:
> >
> > Except that your implementation of it is not good.
> >
> > You're relying on the old obsolete flash binding with the "probe-type"
> > field.  The solution should be adapted to the new approach which uses
> > values in the "compatible" field to indicate various sorts of flash
> > device.
>=20
> What "compatible" values should I use for ROM and RAM mappings ?

That I'm not so sure of.  We'll need to find some consensus.

There may be existing IEEE1275 bindings for roms, which we should
investigate.  Arguably RAM should be represented by a memory node, but
that's going to get messy for this sort of application.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH1wpwaILKxv3ab8YRAtFsAJ4oLMQCnrh6dQicU7h2+liQsiwQVACdGm/a
ULO9we1PJ/LcnUnicwABH7I=
=DE/E
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
