Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A0054DDE3F
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 21:54:57 +1000 (EST)
Date: Mon, 23 Jul 2007 21:55:11 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Chen Gong <g.chen@freescale.com>
Subject: Re: [PATCH 0/3] Add virq mapping debugfs for PowerPC
Message-Id: <20070723215511.3c7b9268.sfr@canb.auug.org.au>
In-Reply-To: <11851892302391-git-send-email-g.chen@freescale.com>
References: <11851892302391-git-send-email-g.chen@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__23_Jul_2007_21_55_11_+1000_8VMZwKV6ydBxvC=r"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__23_Jul_2007_21_55_11_+1000_8VMZwKV6ydBxvC=r
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 23 Jul 2007 19:13:47 +0800 Chen Gong <g.chen@freescale.com> wrote:
>
> [PATCH 1/3] Add a new member name to structure irq_host
> [PATCH 2/3] Add irq host name for interrupt controllors

You should really combine patches 1 and 2 so that the tree will build and
run after each final commit in the git tree (so bisect works better).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__23_Jul_2007_21_55_11_+1000_8VMZwKV6ydBxvC=r
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGpJclTgG2atn1QN8RAqNvAKCO9iFzx1je0aQemIuUyU296au6KQCfQa8p
LT/PjMDY4rjukI2fOTn+Juc=
=6LkY
-----END PGP SIGNATURE-----

--Signature=_Mon__23_Jul_2007_21_55_11_+1000_8VMZwKV6ydBxvC=r--
