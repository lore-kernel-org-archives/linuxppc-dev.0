Return-Path: <michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
To: Kumar Gala <galak@gate.crashing.org>
Date: Tue, 15 Nov 2005 10:47:54 +1100
References: <Pine.LNX.4.44.0511141655560.8331-100000@gate.crashing.org>
In-Reply-To: <Pine.LNX.4.44.0511141655560.8331-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart27625073.DqQt07v5Gx";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200511151047.57684.michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, linuxppc64@gate.crashing.org
Subject: Re: asm-ppc/page.h vs asm-powerpc/page.h
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart27625073.DqQt07v5Gx
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

My original patch removed it, so Paulus must have kept if for some good=20
reason.

asm-powerpc/page.h probably should have page_to_virt, I'm not sure why I to=
ok=20
it out :?

cheers

On Tue, 15 Nov 2005 10:01, Kumar Gala wrote:
> Guys, what's going on here.
>
> Why haven't we removed asm-ppc/page.h?
>
> When I build ARCH=3Dpowerpc I get asm-powerpc/page.h, which doesn't build=
 on
> 85xx since page_to_virt is missing.
>
> Any reason we are keeping around asm-ppc/page.h and causing this
> confusion?
>
> - kumar

=2D-=20
Michael Ellerman
IBM OzLabs

email: michael:ellerman.id.au
inmsg: mpe:jabber.org
wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--nextPart27625073.DqQt07v5Gx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD4DBQBDeSItdSjSd0sB4dIRAq9NAJ4kc2hk3jKYE5aonr2cdpWXgAnCPgCY1woL
ipXnW/HcpI3TH0xWRijS4g==
=R9Zv
-----END PGP SIGNATURE-----

--nextPart27625073.DqQt07v5Gx--
