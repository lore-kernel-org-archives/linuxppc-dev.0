Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E3158DDE4A
	for <linuxppc-dev@ozlabs.org>; Sat, 12 May 2007 18:28:38 +1000 (EST)
Subject: Re: [PATCH 7/7] MPIC U3/U4 MSI backend
From: Johannes Berg <johannes@sipsolutions.net>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <20070508025843.0D93ADDEFD@ozlabs.org>
References: <20070508025843.0D93ADDEFD@ozlabs.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-+SzEI+OpYQRpiab8GY7v"
Date: Sat, 12 May 2007 10:28:24 +0200
Message-Id: <1178958505.2647.5.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-+SzEI+OpYQRpiab8GY7v
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


> +	pr_debug("u3msi: allocated virq 0x%x (hw 0x%lx) at address 0x%lx\n",
> +		 virq, virq_to_hw(virq), addr);

I get
arch/powerpc/sysdev/mpic_u3msi.c: In function =E2=80=98u3msi_compose_msi_ms=
g=E2=80=99:
arch/powerpc/sysdev/mpic_u3msi.c:121: warning: format =E2=80=98%lx=E2=80=99=
 expects type
=E2=80=98long unsigned int=E2=80=99, but argument 4 has type =E2=80=98u64=
=E2=80=99

when building this on ppc32 (I wonder if that even makes sense anyway
but Kconfig allowed me to select MSI)

johannes

--=-+SzEI+OpYQRpiab8GY7v
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGRXqo/ETPhpq3jKURAggEAJ0WX8eMefXi+L8vgCHzA/42QImxzACfQ85x
qz11hU5TMAnIMzjVN5ycE1g=
=gpb9
-----END PGP SIGNATURE-----

--=-+SzEI+OpYQRpiab8GY7v--
