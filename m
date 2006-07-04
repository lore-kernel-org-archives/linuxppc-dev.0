Return-Path: <michael@ellerman.id.au>
Subject: Re: "boot: mem=1024M" causes only one CPU is brought up in 2.6.17-mm4
From: Michael Ellerman <michael@ellerman.id.au>
To: Raid Cheng <chenglei@gmail.com>
In-Reply-To: <b7ddee480606300005p15367a6al4db562f8d0b885d9@mail.gmail.com>
References: <b7ddee480606300005p15367a6al4db562f8d0b885d9@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-0x+o4N+T1OARVGxSVLVm"
Date: Tue, 04 Jul 2006 17:18:29 +1000
Message-Id: <1151997509.8681.31.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-0x+o4N+T1OARVGxSVLVm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-06-30 at 15:05 +0800, Raid Cheng wrote:
> I installed latest mm kernel 2.6.17-mm4 on ppc64 with RHEL4-U3.
> When i tried to limit the memory to 1024M by modifying yaboot.conf or
> typing on the boot line, I found some error messages in dmesg log
> and only one CPU is brought up by checking /proc/cpuinfo.

I've just posted a fix:
"[PATCH] Fix mem=3D handling when the memory limit is > RMO".

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-0x+o4N+T1OARVGxSVLVm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEqhZFdSjSd0sB4dIRAhT/AJoDZSy3f4p07ablwrmHSYcMnsSzEACfXULk
Vuf3CpRIvaKZc6qf4sVXCLQ=
=zoMp
-----END PGP SIGNATURE-----

--=-0x+o4N+T1OARVGxSVLVm--
