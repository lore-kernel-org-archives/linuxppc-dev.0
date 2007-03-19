Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BC9BCDDED4
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 02:24:09 +1100 (EST)
Subject: Re: [PATCH 2/5] powerpc: fix suspend states again
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1174315727.5044.6.camel@localhost.localdomain>
References: <20070319105352.771599000@sipsolutions.net>
	<20070319105358.796834000@sipsolutions.net>
	<1174315727.5044.6.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-YobLrOv95cuXSBLQcVU2"
Date: Mon, 19 Mar 2007 16:22:06 +0100
Message-Id: <1174317726.22561.4.camel@johannes.berg>
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


--=-YobLrOv95cuXSBLQcVU2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-03-19 at 15:48 +0100, Benjamin Herrenschmidt wrote:

> > I removed
> > 	set_context(current->active_mm->context.id, current->active_mm->pgd);

> No, you need that to restore the segment registers. I might work for you
> by mere luck.

Hm, I thought they were saved by the lowlevel code, but yeah. I'll need
to see where to put this. Btw, it looks like it's missing in
powerbook_sleep_3400 as well?

johannes

--=-YobLrOv95cuXSBLQcVU2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBF/qqe/ETPhpq3jKURAl+iAJ9uy2sL0LGb4rpo1giWWez0YToUqACdGbmk
p7GhKd5TyxFXb35asFPbHbw=
=oyYL
-----END PGP SIGNATURE-----

--=-YobLrOv95cuXSBLQcVU2--
