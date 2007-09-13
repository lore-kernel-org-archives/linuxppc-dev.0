Return-Path: <michael@ellerman.id.au>
Subject: Re: 2.6.23-rc3 boot hang on MPC8641D
From: Michael Ellerman <michael@ellerman.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <57BB0290-6787-4504-BC29-0E92AB226E6C@kernel.crashing.org>
References: <12648489.post@talk.nabble.com>
	<85940BCC-C5A7-4461-B49C-A5C1879708C3@kernel.crashing.org>
	<12648671.post@talk.nabble.com>
	<57BB0290-6787-4504-BC29-0E92AB226E6C@kernel.crashing.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-0Pwj2egeiIBWk0+gEFTA"
Date: Thu, 13 Sep 2007 15:59:32 +1000
Message-Id: <1189663172.20396.1.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, sivaji <rameshmrm@gmail.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-0Pwj2egeiIBWk0+gEFTA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-09-13 at 00:13 -0500, Kumar Gala wrote:
> On Sep 12, 2007, at 11:47 PM, sivaji wrote:
>=20
> >
> >
> > Hi,
> >           I have JTAG Debugger connected to the board. I was given the
> > following commands in the root path of the kernel source
>=20
> If you can dump memory w/o connecting GDB, I suggest the following.
>=20
> Look in your kernel build for System.map and grep for log_buf you =20
> should get something like:
>=20
> c040b04c d log_buf
> c043b1a4 b __log_buf
>=20
> then dump the memory @ these addresses.  I can't remember which one =20
> is the correct one.  You'll want to subtract c000_0000 from the =20
> address to get a physical address that you can dump.  This should =20
> help provide some possible insight into what's going on.

__log_buf is the actual buffer, log_buf points to the current insertion
point IIRC. It should be pretty obvious that you're looking at a dmesg
buffer though, unless there's nothing in there for some reason.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-0Pwj2egeiIBWk0+gEFTA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG6NHEdSjSd0sB4dIRAippAJ9gYroQcDeoKSEfWS7Wnf4d6TT9HgCgumAB
sLn1BeP9ao4JPyDqPgtUtcs=
=zsFe
-----END PGP SIGNATURE-----

--=-0Pwj2egeiIBWk0+gEFTA--
