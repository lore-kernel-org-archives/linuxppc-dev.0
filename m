Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] add icswx support
From: Michael Ellerman <michael@ellerman.id.au>
To: "Tseng-Hui (Frank) Lin" <thlin@linux.vnet.ibm.com>
In-Reply-To: <1272405410.6329.16.camel@flin.austin.ibm.com>
References: <1272060275.6329.13.camel@flin.austin.ibm.com>
	<1272070551.2330.213.camel@pasglop>
	<1272405410.6329.16.camel@flin.austin.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-3a0/Zc9r0AEVl6unjoFy"
Date: Fri, 30 Apr 2010 23:35:22 +1000
Message-ID: <1272634522.9367.0.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-3a0/Zc9r0AEVl6unjoFy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2010-04-27 at 16:56 -0500, Tseng-Hui (Frank) Lin wrote:
> On Sat, 2010-04-24 at 10:55 +1000, Benjamin Herrenschmidt wrote:
> > On Fri, 2010-04-23 at 17:04 -0500, Tseng-Hui (Frank) Lin wrote:
> > > Add Power7 icswx co-processor instruction support.
> >=20
> > Please provide a -much- more detailed explanation of what it is, what i=
t
> > does and why it requires hooking into the MMU context switch code. _I_
> > know these things but nobody else on the list does which limits the
> > ability of people to review your patch.
> >
>=20
> icswx is a PowerPC co-processor instruction to send data to a=20
> co-processor. On Book-S processors the LPAR_ID and process ID (PID) of=20
> the owning process are registered in the window context of the
> co-processor at initial time. When the icswx instruction is executed,
> the L2 generates a cop-reg transaction on PowerBus. The transaction has
> no address and the processor does not perform an MMU access to=20
> authenticate the transaction. The coprocessor compares the LPAR_ID and
> the PID included in the transaction and the LPAR_ID and PID held in the
> window context to determine if the process is authorized to generate the
> transaction.

How does userspace discover that there are coprocessors to send requests
to? And how does the coprocessor send results back to the process?

cheers


--=-3a0/Zc9r0AEVl6unjoFy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkva3JYACgkQdSjSd0sB4dKrbACglS1/4p4gJG0+flRwII/3Kt5S
MdMAoI0PocSRyBCVvejqvw3Lhwh+SsWi
=hTea
-----END PGP SIGNATURE-----

--=-3a0/Zc9r0AEVl6unjoFy--
