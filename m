Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id EE9C2DDDFA
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 10:43:24 +1100 (EST)
Date: Mon, 10 Dec 2007 10:43:12 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Olof Johansson <olof@lixom.net>
Subject: CC munging by mailman lists (Was: Re: [PATCH 18/25] powerpc: Base
	support for 440GX Taishan eval board)
Message-Id: <20071210104312.3b2a756a.sfr@canb.auug.org.au>
In-Reply-To: <20071209172404.GA26651@lixom.net>
References: <1196927999.714593.205329520306.qpush@grosgo>
	<20071206080129.737E8DE09F@ozlabs.org>
	<20071206211758.6f086161@zod.rchland.ibm.com>
	<1197183715.6572.8.camel@pasglop>
	<20071209172404.GA26651@lixom.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__10_Dec_2007_10_43_12_+1100_DwkcL8Azfq5wJO.B"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__10_Dec_2007_10_43_12_+1100_DwkcL8Azfq5wJO.B
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 9 Dec 2007 11:24:04 -0600 Olof Johansson <olof@lixom.net> wrote:
>
> I didn't see him Cc:d on the patch submission, and I'm guessing Josh did
> a reply-all. Seems as if the mailing list manager strips Cc fields of
> people already subscribed to the list, I've seen it before.

Ok, this is a per user setting with the default for new users set to
attempt to strip the user from the CC header if they are a member of the
list.

I have now changed the default for new users to not do this stripping.
Current users can change their own setting by going to
https://ozlabs.org/listinfo/linuxppc-dev and changing the "Avoid
duplicate copies of messages?" option.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__10_Dec_2007_10_43_12_+1100_DwkcL8Azfq5wJO.B
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHXH2VTgG2atn1QN8RAp15AJ9xzCXHS7ERb2PZSB7lBxWIMsm9fwCfdN68
6oZ/gt5UuZdsmvxu8X15EqQ=
=nfkl
-----END PGP SIGNATURE-----

--Signature=_Mon__10_Dec_2007_10_43_12_+1100_DwkcL8Azfq5wJO.B--
