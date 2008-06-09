Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id B9DF7DDF9B
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2008 09:15:58 +1000 (EST)
Date: Tue, 10 Jun 2008 09:15:45 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Stefan Roscher <ossrosch@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] ibmebus: Change ibmebus_request_irq() to optionally
	return irq number
Message-Id: <20080610091545.eb36d72f.sfr@canb.auug.org.au>
In-Reply-To: <200806091744.30930.ossrosch@linux.vnet.ibm.com>
References: <200806091744.30930.ossrosch@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__10_Jun_2008_09_15_45_+1000_KSWuMORr5A4Yt6.m"
Cc: TKLEIN@de.ibm.com, THEMANN@de.ibm.com, fenkes@de.ibm.com,
	OF-EWG <ewg@lists.openfabrics.org>, LKML <linux-kernel@vger.kernel.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>, raisch@de.ibm.com,
	OF-General <general@lists.openfabrics.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__10_Jun_2008_09_15_45_+1000_KSWuMORr5A4Yt6.m
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

On Mon, 9 Jun 2008 17:44:29 +0200 Stefan Roscher <ossrosch@linux.vnet.ibm.c=
om> wrote:
>
> Signed-off-by: Stefan Roscher <stefan.roscher@de.ibm.com>

Before Paulus gets to you:  Why are we doing this?  Please write an
explanatory commit message.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__10_Jun_2008_09_15_45_+1000_KSWuMORr5A4Yt6.m
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhNuaEACgkQTgG2atn1QN9a/QCfTnObsOEEainNPvQaRDPhBLKv
j9UAoIPBPZVy8IBXcJ7pNRAonJW1xFS3
=6Sx0
-----END PGP SIGNATURE-----

--Signature=_Tue__10_Jun_2008_09_15_45_+1000_KSWuMORr5A4Yt6.m--
