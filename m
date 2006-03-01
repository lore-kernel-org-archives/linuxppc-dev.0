Return-Path: <michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
To: fastboot@lists.osdl.org
Subject: Re: [Fastboot] Re: Kexec for booke PPC processors
Date: Thu, 2 Mar 2006 10:12:54 +1100
References: <3d42041d0603011443v4840d65en4f0676ff86c44e@mail.gmail.com>
In-Reply-To: <3d42041d0603011443v4840d65en4f0676ff86c44e@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200603021012.57955.michael@ellerman.id.au>
Content-Type: multipart/signed; boundary="nextPart1175347.Zf7CbuD8Wz";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Cc: linuxppc-dev@ozlabs.org, dagriego <dagriego@gmail.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1175347.Zf7CbuD8Wz
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thu, 2 Mar 2006 09:43, dagriego wrote:
> I'm finishing my first pass on getting kexec to work on PPC booke
> processor, and needed some insight into how to pass information from the
> first kernel to the kexec'ed kernel.  This information is the board
> information that the first kernel is given in r3 from the board firmware.=
=20
> Is there a standard convention for passing this information?

Yep, it's called the flat device tree.

cheers

=2D-=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--nextPart1175347.Zf7CbuD8Wz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEBip5dSjSd0sB4dIRAr+EAJsFEnB23P4omib3bGECowhySjcXewCgo0cu
1Md+3Yqo027s+zG5XUOFyJg=
=dcx6
-----END PGP SIGNATURE-----

--nextPart1175347.Zf7CbuD8Wz--
