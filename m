Return-Path: <michael@ellerman.id.au>
Subject: Re: nfsd, v4: oops in find_acceptable_alias, ppc32 Linux,
	post-2.6.27-rc1
From: Michael Ellerman <michael@ellerman.id.au>
To: Paul Collins <paul@burly.ondioline.org>
In-Reply-To: <87y73dcd60.fsf@burly.wgtn.ondioline.org>
References: <87tze38vzt.fsf@burly.wgtn.ondioline.org>
	<20080802184554.GB715@fieldses.org>
	<87abfvm4cc.fsf@burly.wgtn.ondioline.org>
	<877iayy4qc.fsf@burly.wgtn.ondioline.org>
	<18581.40960.737792.454035@notabene.brown>
	<87r696l1yo.fsf@burly.wgtn.ondioline.org>
	<18582.32935.501672.689845@notabene.brown>
	<87fxpll5zq.fsf@burly.wgtn.ondioline.org>
	<87y73dcd60.fsf@burly.wgtn.ondioline.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-MkOS6eDoTSlB2pgYL8IH"
Date: Tue, 05 Aug 2008 00:36:37 +1000
Message-Id: <1217860597.12535.2.camel@localhost>
Mime-Version: 1.0
Cc: Neil Brown <neilb@suse.de>, "J. Bruce Fields" <bfields@fieldses.org>,
	nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-MkOS6eDoTSlB2pgYL8IH
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-08-04 at 22:00 +1200, Paul Collins wrote:
> Paul Collins <paul@burly.ondioline.org> writes:
>=20
> > Neil Brown <neilb@suse.de> writes:
> >> Could you try removing the 'static' declaration for nfsd_acceptable
> >> and recompile?
> >> Or maybe try a different compiler?
> >
> > I will give these a try this evening.
>=20
> I built myself a nice new cross compiler:
>=20
>         powerpc-linux-gnu-gcc-4.1 (GCC) 4.1.3 20080623 (prerelease) (Debi=
an 4.1.2-23)
>=20
> and rebuilt 94ad374a0751f40d25e22e036c37f7263569d24c.  Running that on
> the server and 2.6.26 on the client, I got yet another Oops.  This one
> locked the machine up pretty good, so all I have is a picture:
>=20
> http://ondioline.org/~paul/DSCN1608.JPG

Wow.

Can you try building a kernel on the server? ie. not over NFS.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-MkOS6eDoTSlB2pgYL8IH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIlxP1dSjSd0sB4dIRAgmYAJ9hCUcQnhwq+Py35p+cElMtYVaBhQCfdOM2
vzAo/x4cd7NeQ8LPuUZN+ws=
=S/Go
-----END PGP SIGNATURE-----

--=-MkOS6eDoTSlB2pgYL8IH--
