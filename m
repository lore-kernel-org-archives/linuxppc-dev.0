Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 17DB3B7D88
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jun 2010 10:54:00 +1000 (EST)
Date: Fri, 11 Jun 2010 10:53:53 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 5/5] hvc_console: Fix race between hvc_close and hvc_remove
Message-Id: <20100611105353.e4074525.sfr@canb.auug.org.au>
In-Reply-To: <1276167780-23002-6-git-send-email-jkacur@redhat.com>
References: <1276167780-23002-1-git-send-email-jkacur@redhat.com>
	<1276167780-23002-6-git-send-email-jkacur@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__11_Jun_2010_10_53_53_+1000_3q4/VhSy9uDpcNKZ"
Cc: Rusty Russell <rusty@rustcorp.com.au>, Clark Williams <williams@redhat.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linuxppc-dev@ozlabs.org, Amit Shah <amit.shah@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Fri__11_Jun_2010_10_53_53_+1000_3q4/VhSy9uDpcNKZ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi John,

On Thu, 10 Jun 2010 13:03:00 +0200 John Kacur <jkacur@redhat.com> wrote:
>
> From: Amit Shah <amit.shah@redhat.com>
>=20
> Alan pointed out a race in the code where hvc_remove is invoked. The
> recent virtio_console work is the first user of hvc_remove().

I am not sure where this comes from (linuxppc-dev only got 5/5) but this
patch was applied to Linus' tree quite some time age (and fixed since
then).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__11_Jun_2010_10_53_53_+1000_3q4/VhSy9uDpcNKZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkwRiSEACgkQjjKRsyhoI8yylgCfY9U0dyrAfTP2rvGW8lRRF+jW
9JAAnAoWjPq8AtNfjOOBMrXBHP6uuph+
=DcOM
-----END PGP SIGNATURE-----

--Signature=_Fri__11_Jun_2010_10_53_53_+1000_3q4/VhSy9uDpcNKZ--
