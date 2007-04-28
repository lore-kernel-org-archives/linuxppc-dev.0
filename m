Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E4AC5DDF52
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Apr 2007 23:46:25 +1000 (EST)
Subject: Re: [PATCH] powermac: proper sleep management
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17971.14223.435220.418649@cargo.ozlabs.ibm.com>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
	<1177746562.3448.10.camel@johannes.berg>
	<17971.14223.435220.418649@cargo.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-2p6RuiHgvLGsAQu01isg"
Date: Sat, 28 Apr 2007 15:46:35 +0200
Message-Id: <1177767996.5102.9.camel@johannes.berg>
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


--=-2p6RuiHgvLGsAQu01isg
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2007-04-28 at 22:01 +1000, Paul Mackerras wrote:

> I would very much rather that we keep the existing code path intact
> and add the code to suspend via /sys/power/state as a separate code
> path.=20

Are you serious? The only thing the generic code does here is invoke our
stuff in the right order. That shouldn't be too much of a constraint. We
don't even have multiple CPUs or anything that was recently giving
problems.

> I am not confident enough about the state of the generic
> suspend/resume code to commit to using it as the only way to suspend
> to RAM, given how many bugs it seems to have (as evidenced by the
> number of suspend-related bugs in Adrian Bunk's regression lists, for
> instance).

Of the suspend related bugs Adrian's regression list most aren't really
related to the generic code we rely on, especially since all machines
this code applies to are single-CPU. Besides, relying on it is the only
way to ensure it stays compatible.

johannes

--=-2p6RuiHgvLGsAQu01isg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGM1A7/ETPhpq3jKURAjIMAJ4gVkpHnKfhJJ0YPph81tdGbetEUgCdHTAZ
9dFOg/2ox/jmukrNnVedga4=
=D5pw
-----END PGP SIGNATURE-----

--=-2p6RuiHgvLGsAQu01isg--
