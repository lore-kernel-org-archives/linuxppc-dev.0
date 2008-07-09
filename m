Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 538B3DDF90
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 03:23:54 +1000 (EST)
Date: Thu, 10 Jul 2008 03:23:46 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Updates to powerpc.git
Message-Id: <20080710032346.62545256.sfr@canb.auug.org.au>
In-Reply-To: <20080709162008.GC28130@secretlab.ca>
References: <1215588881.8970.358.camel@pasglop>
	<7CAAEE49-56F0-4565-8F1B-374C5E2F9E42@kernel.crashing.org>
	<20080710020832.3e654bc9.sfr@canb.auug.org.au>
	<20080709162008.GC28130@secretlab.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__10_Jul_2008_03_23_46_+1000_9q8lRd0UcmDnxS5K"
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__10_Jul_2008_03_23_46_+1000_9q8lRd0UcmDnxS5K
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Grant,

On Wed, 9 Jul 2008 10:20:08 -0600 Grant Likely <grant.likely@secretlab.ca> =
wrote:
>
> I was under the impression that there was some consensus that -next
> branches should be used for unstable experiments.  Am I mistaken?

Completely.  Anything that will end up in linux-next must be posted,
reviewed, unit tested and intended for the next merge window.  i.e. you
must have basically finished with it (except for inter-subsystem merge
problems and bugs, or course).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__10_Jul_2008_03_23_46_+1000_9q8lRd0UcmDnxS5K
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkh09CIACgkQjjKRsyhoI8zY8ACfZPQeYe7CdrwYcqdQPisbwqzp
qqwAoIiZIUn5kbBTuhh/CRRTjjn7Tsq4
=0N0T
-----END PGP SIGNATURE-----

--Signature=_Thu__10_Jul_2008_03_23_46_+1000_9q8lRd0UcmDnxS5K--
