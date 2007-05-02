Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6EB00DDE3D
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 00:33:10 +1000 (EST)
Subject: Re: [PATCH] powermac: support G5 CPU hotplug
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17976.28170.695715.416339@cargo.ozlabs.ibm.com>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
	<1178086872.13233.27.camel@johannes.berg>
	<17976.28170.695715.416339@cargo.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-FdpCIbuxZoPDn/MbF4rp"
Date: Wed, 02 May 2007 16:33:58 +0200
Message-Id: <1178116438.13233.65.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-FdpCIbuxZoPDn/MbF4rp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-05-02 at 20:55 +1000, Paul Mackerras wrote:

> Ultimately we want to put the disabled cpus in sleep mode, but that
> will require a suitable cache flush routine.

I don't have any docs for the particular processors the G5s have, do
they have a sleep mode?

johannes

--=-FdpCIbuxZoPDn/MbF4rp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGOKFW/ETPhpq3jKURAnphAJ91KfA073Y4rZvY7+7xUkvqbTEOzQCfX1GZ
g5mtDxDnqik10aHQEibgPhM=
=iEy+
-----END PGP SIGNATURE-----

--=-FdpCIbuxZoPDn/MbF4rp--
