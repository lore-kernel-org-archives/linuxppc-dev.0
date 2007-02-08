Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A281ADDED8
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 02:40:59 +1100 (EST)
Subject: Re: [PATCH 02/12] powermac: support G5 CPU hotplug
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1170941321.4385.61.camel@johannes.berg>
References: <20070207124536.963531000@sipsolutions.net>
	<20070207124610.392302000@sipsolutions.net>
	<1170940494.4385.51.camel@johannes.berg>
	<1170941321.4385.61.camel@johannes.berg>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-A/EJZGzzs6gtQSLRxE8G"
Date: Thu, 08 Feb 2007 16:38:19 +0100
Message-Id: <1170949099.4385.67.camel@johannes.berg>
Mime-Version: 1.0
Cc: linux-pm@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-A/EJZGzzs6gtQSLRxE8G
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-02-08 at 14:28 +0100, Johannes Berg wrote:
>=20
> +#ifdef CONFIG_CPU_HOTPLUG
> +       /* if we have fake CPU hotplug just to support suspend to disk
> +        * and can't really turn off a CPU, it may be taking timer interr=
upts
> +        * even when it is dead. Avoid doing anything in that case so glo=
bal
> +        * state is not modified for and by a CPU that doesn't really exi=
st. */
> +       if (__get_cpu_var(cpu_state) =3D=3D CPU_DEAD)
> +               return;
> +#endif

Michael Buesch suggested to add an unlikely() there which I'll do for
the next round.

johannes

--=-A/EJZGzzs6gtQSLRxE8G
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFy0Pr/ETPhpq3jKURAlUXAJsF+/uwDThXLNwaCFJAiEjWfFoxfwCglNRf
2v5yc0jCi+ZqI2beGp+MyAs=
=PK2k
-----END PGP SIGNATURE-----

--=-A/EJZGzzs6gtQSLRxE8G--
