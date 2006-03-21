Return-Path: <michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 7/7] powerpc numa: Consolidate assignment of cpus to nodes
Date: Wed, 22 Mar 2006 10:09:14 +1100
References: <11429014352189-git-send-email-nathanl@austin.ibm.com>
	<1142966317.10906.172.camel@localhost.localdomain>
	<1142968571.27114.28.camel@pants.austin.ibm.com>
In-Reply-To: <1142968571.27114.28.camel@pants.austin.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1168872.MvgYH8zqAM";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200603221009.19523.michael@ellerman.id.au>
Cc: Nathan Lynch <nathanl@austin.ibm.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1168872.MvgYH8zqAM
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wed, 22 Mar 2006 06:16, Nathan Lynch wrote:
> On Tue, 2006-03-21 at 10:38 -0800, Dave Hansen wrote:
> > By the way, what do the "l" and "h" in front of "cpu" mean anyway?
>
> "logical" and "hot"?  I dunno, just seemed to be the convention in other
> cpu notifiers at the time the code was written.

Ouch, that's unfortunate. In the powerpc code hcpu _usually_ means hard cpu=
=20
number, as opposed to logical (lcpu). In this case though it looks like hcp=
u=20
holds the logical cpu number, which is a bit icky. That might be worth=20
fixing.

cheers

=2D-=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--nextPart1168872.MvgYH8zqAM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEIIefdSjSd0sB4dIRAoR0AKCM2+Q7k8tsZYMW+HFmgqy3QNIvygCdGMR3
zGmsLrGl1z/qrzf/v86TJlM=
=PJ0J
-----END PGP SIGNATURE-----

--nextPart1168872.MvgYH8zqAM--
