Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BB0F7DDFAC
	for <linuxppc-dev@ozlabs.org>; Tue,  1 May 2007 19:05:50 +1000 (EST)
Subject: Re: patches for 2.6.22
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-k2GIPybmZMO7WoAIyyLP"
Date: Tue, 01 May 2007 11:06:28 +0200
Message-Id: <1178010389.3483.9.camel@johannes.berg>
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


--=-k2GIPybmZMO7WoAIyyLP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-04-27 at 21:25 +1000, Paul Mackerras wrote:

> If anyone has patches that I haven't picked up yet which they think
> should go into 2.6.22

Oh another thing is my suspend-to-disk work. Most of the patches to
drivers have been reviewed by various people around, but afaik nobody
has given the core code much of a look. It's a new feature and could be
marked EXPERIMENTAL or such, so it can't introduce regressions. I can
repost for consideration but since I never received much comments I
never bothered.

johannes

--=-k2GIPybmZMO7WoAIyyLP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGNwMU/ETPhpq3jKURAtjSAKCZusRRPdkA1OOKenJnuorugO7hvgCghjPa
rNqf9Fc17ukWa3BeQGkucIA=
=tJ/h
-----END PGP SIGNATURE-----

--=-k2GIPybmZMO7WoAIyyLP--
