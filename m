Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 741D7DDE4A
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 22:16:38 +1000 (EST)
Date: Thu, 10 May 2007 22:16:31 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andy Whitcroft <apw@shadowen.org>
Subject: Re: 2.6.21-mm2 -- powerpc missing kset
Message-Id: <20070510221631.5eb38bdd.sfr@canb.auug.org.au>
In-Reply-To: <4643068C.8010302@shadowen.org>
References: <20070509012322.199f292b.akpm@linux-foundation.org>
	<4643068C.8010302@shadowen.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__10_May_2007_22_16_31_+1000_3HuKn4/ZQPPOnIhR"
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__10_May_2007_22_16_31_+1000_3HuKn4/ZQPPOnIhR
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Thu, 10 May 2007 12:48:28 +0100 Andy Whitcroft <apw@shadowen.org> wrote:
>
> arch/powerpc/platforms/pseries/power.c:31: warning: `struct subsystem'
> declared inside parameter list

There is no explicit reference to struct subsystem in the current version
of that file.

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__10_May_2007_22_16_31_+1000_3HuKn4/ZQPPOnIhR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGQw0kFdBgD/zoJvwRAvZyAJwM3NoM8kedpL+fUT3LHfI68tDqVACfTHX6
cMfZ2F/JfCoNfCXbEM3DmF0=
=l/Nd
-----END PGP SIGNATURE-----

--Signature=_Thu__10_May_2007_22_16_31_+1000_3HuKn4/ZQPPOnIhR--
