Return-Path: <michael@ellerman.id.au>
Subject: Re: [RFC/PATCH 14/16] MPIC MSI backend
From: Michael Ellerman <michael@ellerman.id.au>
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m1ejphvfho.fsf@ebiederm.dsl.xmission.com>
References: <1169714047.65693.647693675533.qpush@cradle>
	<20070125083417.69895DE3C5@ozlabs.org>
	<20070126064352.GA328@colo.lackof.org>
	<m1ejpiw9s8.fsf@ebiederm.dsl.xmission.com>
	<5A6F70E0-A8AB-4636-8F41-2EC82A3B13B7@kernel.crashing.org>
	<m1r6thvjdq.fsf@ebiederm.dsl.xmission.com>
	<20070126171928.GA22275@colo.lackof.org>
	<m1ejphvfho.fsf@ebiederm.dsl.xmission.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-vJfFX3p4aLnLxIQVdAul"
Date: Sat, 27 Jan 2007 18:01:50 +1100
Message-Id: <1169881310.2294.43.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: Grant Grundler <grundler@parisc-linux.org>,
	Greg Kroah-Hartman <greg@kroah.com>,
	Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Brice Goglin <brice@myri.com>, shaohua.li@intel.com,
	linux-pci@atrey.karlin.mff.cuni.cz, "David S.Miller" <davem@davemloft.net>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-vJfFX3p4aLnLxIQVdAul
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-01-26 at 10:56 -0700, Eric W. Biederman wrote:
> Grant Grundler <grundler@parisc-linux.org> writes:
> > Helping Michael make it work would be a constructive way forward.
> > I think Michael has the abstraction correct so it's NOT x86 centric
> > but still works optimally on x86.
>=20
> NO NO NO NO Michaels abstraction does not work on x86.
> Which is a big part of the my problem.
> Michaels abstraction does not allow me to migrate irqs on x86.
>=20
> setup_msi_msg only gets called when you enable the msi.  Nothing
> gets called when irqbalaced changes the cpu mask, and there is no
> support that would allow that with Michael's msi ops.

That's all part of the backend. You just give me an irq_desc attached to
a chip with set_affinity =3D set_msi_irq_affinity, exactly like the
current code.

> That is why I have asked for an evolutionary approach and not this
> stupid drop and replace attempt.

I don't intend to drop and replace, I agree that's stupid. My hope was
to have the two implementations coexist for a kernel release, giving us
time to find all the bugs on PowerPC - where we have lots fewer MSI
users to piss off - and then port Intel over.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-vJfFX3p4aLnLxIQVdAul
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFuvjedSjSd0sB4dIRAuBZAKCwN+5myUnnHi5SXDnAkpwW6lo+iQCgxZ8Y
tXBkuLPQKAWklblpiZdJHZY=
=2lYy
-----END PGP SIGNATURE-----

--=-vJfFX3p4aLnLxIQVdAul--
