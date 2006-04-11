Return-Path: <michael@ellerman.id.au>
Subject: Re: [RFC/PATCH] powerpc: Use rtas query-cpu-stopped-state in smp
	spinup
From: Michael Ellerman <michael@ellerman.id.au>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <20060407011002.GF9208@localdomain>
References: <20060404112459.C9170679EB@ozlabs.org>
	<20060404172550.GE25663@localdomain>
	<1144236210.6788.6.camel@localhost.localdomain>
	<20060407011002.GF9208@localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-x1AbwUm2y3Ih5pNKd+Ic"
Date: Tue, 11 Apr 2006 10:53:20 +0200
Message-Id: <1144745600.25733.2.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-x1AbwUm2y3Ih5pNKd+Ic
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-04-06 at 20:10 -0500, Nathan Lynch wrote:
> I tried your patch (non-kexec boot) on a 1-way SMT power5 with
> 2.6.17-rc1 and got the badness below, and I think it matches what I
> ran into in the past.  Maybe doing query-cpu-stopped-state on a thread
> that has yet to be started by RTAS mucks things up?
>=20
> Memory: 2047640k/2097152k available (5356k kernel code, 49512k
> reserved, 1412k data, 900k bss, 240k init)
> Calibrating delay loop... 375.80 BogoMIPS (lpj=3D751616)
> Security Framework v1.0.0 initialized
> SELinux:  Disabled at boot.
> Mount-cache hash table entries: 256
> Processor 1 is stuck.               <<<<<<<<

OK, thanks for testing it. This is clearly not going to fly.

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-x1AbwUm2y3Ih5pNKd+Ic
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEO26AdSjSd0sB4dIRAqmHAKCLQV9OEPsfSvLl+ghnXNYSeYomXwCgyueh
LtlchO8oFZ5gmZ4TTquOflQ=
=RAmY
-----END PGP SIGNATURE-----

--=-x1AbwUm2y3Ih5pNKd+Ic--
