Return-Path: <joerg@dorchain.net>
Received: from Redstar.dorchain.net (153-133-088-212.ip-addr.teresto.net
	[212.88.133.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4F99567A6C
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Mar 2005 18:57:29 +1100 (EST)
Date: Fri, 4 Mar 2005 08:57:03 +0100
From: Joerg Dorchain <joerg@dorchain.net>
To: evilninja <evilninja@gmx.net>, linuxppc-dev@ozlabs.org
Message-ID: <20050304075703.GA15637@Redstar.dorchain.net>
References: <20050303124435.GA24233@Redstar.dorchain.net>
	<4227153C.3030201@gmx.net>
	<20050303141832.GU25080@Redstar.dorchain.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
In-Reply-To: <20050303141832.GU25080@Redstar.dorchain.net>
Subject: Re: boot time scheduling hile atomic (was: GCC4 fun.)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 03, 2005 at 03:18:32PM +0100, Joerg Dorchain wrote:
> >=20
> > > scheduling while atomic: swapper/0x00000002/0
> > > Call trace:
> > >  [c0007620] dump_stack+0x18/0x28
> > >  [c01de704] schedule+0x678/0x67c
> > >  [c0004500] syscall_exit_work+0x108/0x10c
> > >  [c02a97b4] proc_root_init+0x168/0x174
> > >  [ff847288] 0xff847288
> > >  [c02945e8] start_kernel+0x144/0x170
> > >  [00003a30] 0x3a30
> >=20
> > i don't know why you're getting this error, but seeing "swapper" to be
> > involved here: can you compile with CONFIG_SWAP=3Dn and boot this one?
>=20
> I'll do tonight.

Did so, no effect on this. IMHO "swapper" is a somewhat misguiding name
for the idle task with pid 0.

I am more wondering what in proc_root_init or immediately after it
causes a call to the exit_work syscall.

Bye,

Joerg

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCKBTPjY4+4PdzvOARArZaAJ4y/SEQNh9hfhzbt9cdj+5wB2mjpwCfZz5h
qZa4BJ65qgeCsKxwMUYruTI=
=Z/oM
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
