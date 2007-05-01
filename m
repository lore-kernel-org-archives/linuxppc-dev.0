Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 9926CDDF52
	for <linuxppc-dev@ozlabs.org>; Tue,  1 May 2007 10:57:47 +1000 (EST)
Date: Tue, 1 May 2007 10:58:05 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Simon Arlott <simon@fire.lp0.eu>
Subject: Re: Revert "[POWERPC] <various>"
Message-Id: <20070501105805.a27984d8.sfr@canb.auug.org.au>
In-Reply-To: <463649D5.9000406@simon.arlott.org.uk>
References: <46362B14.6090106@simon.arlott.org.uk>
	<20070430194911.GA1156@aepfle.de>
	<463649D5.9000406@simon.arlott.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__1_May_2007_10_58_05_+1000_l/Q4OEUZ6OcTxTbm"
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>,
	Mailing List <linux-kernel@vger.kernel.org>, Linux
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__1_May_2007_10_58_05_+1000_l/Q4OEUZ6OcTxTbm
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Mon, 30 Apr 2007 20:56:05 +0100 Simon Arlott <simon@fire.lp0.eu> wrote:
>
> The reverts themselves are not the real problem, a git bisect could occur
> between the commit adding it and the one that reverts it. If that commit
> introduced a bug then surely it would be better to avoid releasing it
> elsewhere even if it will be reverted in the same batch.

At least one of the reverts was just because the original commit clashed
with a commit in a different tree (netdev) so that will not cause and
build or runtime problems.

> Of course, this is probably difficult to do with git and impossible if
> someone has cloned the bad commit already and tries to pull :/

Not impossible, but it rebases the tree which means that people who have
pulled the tree need to force their next updates.

> Is it possible to mass copy all the good commits to create a clean branch?

It is, but in this case was probably not worth it.

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__1_May_2007_10_58_05_+1000_l/Q4OEUZ6OcTxTbm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGNpCqFdBgD/zoJvwRAlfZAKCVCSIIOzxBuAD+qCnaF2I5s7SfmQCgne8T
qRlkaUsh6lObaacODN3bDF8=
=zj1U
-----END PGP SIGNATURE-----

--Signature=_Tue__1_May_2007_10_58_05_+1000_l/Q4OEUZ6OcTxTbm--
