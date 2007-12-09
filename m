Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 2D879DDDF8
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Dec 2007 17:43:37 +1100 (EST)
Date: Sun, 9 Dec 2007 17:43:25 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jerry Van Baren <gvb.linuxppc.dev@gmail.com>
Subject: Re: Stupid git question: adding acked-by
Message-Id: <20071209174325.5fc42938.sfr@canb.auug.org.au>
In-Reply-To: <475B7B41.4000505@gmail.com>
References: <475B7B41.4000505@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sun__9_Dec_2007_17_43_25_+1100_g6KE=mvvLLzitfrO"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sun__9_Dec_2007_17_43_25_+1100_g6KE=mvvLLzitfrO
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 09 Dec 2007 00:21:05 -0500 Jerry Van Baren <gvb.linuxppc.dev@gmail.=
com> wrote:
>
> OK git gurus, this is something I have not figured out: the best way to=20
> add acked-by (or additional signed-off-by) lines to git patches.

Have a look at "git rebase -i"

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__9_Dec_2007_17_43_25_+1100_g6KE=mvvLLzitfrO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHW46TTgG2atn1QN8RAqaWAJ9ARYb1RNDCrJdCt7kI9KksBQToaQCeJXUh
JXKwX4UkLEx0djZn6YYSjuE=
=7l/4
-----END PGP SIGNATURE-----

--Signature=_Sun__9_Dec_2007_17_43_25_+1100_g6KE=mvvLLzitfrO--
