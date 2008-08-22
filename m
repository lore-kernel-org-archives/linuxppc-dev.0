Return-Path: <michael@ellerman.id.au>
Subject: Re: [machdep_calls] IRQ
From: Michael Ellerman <michael@ellerman.id.au>
To: =?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?=
	<sebastien.chretien.enseirb@gmail.com>
In-Reply-To: <319b0ac50808210123m81e8364od983d5dbbb601104@mail.gmail.com>
References: <319b0ac50808210013p677ebb91vf3b30748138c6d4c@mail.gmail.com>
	<1219305767.8008.14.camel@localhost>
	<319b0ac50808210123m81e8364od983d5dbbb601104@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-wRp+5Z/TZZJ8asJvBaw6"
Date: Fri, 22 Aug 2008 15:20:45 +1000
Message-Id: <1219382445.7861.60.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-wRp+5Z/TZZJ8asJvBaw6
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-08-21 at 10:23 +0200, S=C3=A9bastien Chr=C3=A9tien wrote:
> Exactly, I mean ppc_md.init_IRQ().

> Ok. What have I to setup in this function ? I set the mask and other
> registers. Is it right ?  How do I chose the mask ?

It totally depends on your platform, I really can't tell you. You can
look at similar platform code if there is some, otherwise the reference
manual for your hardware or similar should have what you need.

> At the end of this funtion, IRQ are disable. Is that right ? So who
> does enable IRQs ?

Yes, irqs get enabled a bit later in start_kernel().

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-wRp+5Z/TZZJ8asJvBaw6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIrkytdSjSd0sB4dIRAhgQAKCjAntNPJ/ih8B4WfmExNI55lRQrwCbBILa
+GMHdeLEsRbKYaLTYbiCG4s=
=QcGx
-----END PGP SIGNATURE-----

--=-wRp+5Z/TZZJ8asJvBaw6--
