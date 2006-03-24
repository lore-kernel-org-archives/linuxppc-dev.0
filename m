Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (unknown [213.151.39.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3CBC667A79
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Mar 2006 22:37:38 +1100 (EST)
Received: from [131.234.73.110] (helo=dhcp-73-110.uni-paderborn.de)
	by sipsolutions.net with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.60) (envelope-from <johannes@sipsolutions.net>)
	id 1FMkes-0007pG-6c
	for linuxppc-dev@ozlabs.org; Fri, 24 Mar 2006 11:40:46 +0000
Subject: Re: new sound driver
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1143020119.11724.41.camel@localhost>
References: <1143020119.11724.41.camel@localhost>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-mBtoMAvMcUfr+rKqrOZs"
Date: Fri, 24 Mar 2006 12:37:27 +0100
Message-Id: <1143200247.28247.0.camel@localhost>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-mBtoMAvMcUfr+rKqrOZs
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-03-22 at 10:35 +0100, Johannes Berg wrote:

> So I started to rewrite snd-powermac as snd-aoa, which I currently keep
> in a git tree at http://johannes.sipsolutions.net/snd-aoa.git/

It's a bit hacky (but hopefully those hacks can be removed rather
easily) but it works now for the onyx based machines (powermac8,1, quad
powermac, last 15" powerbook and probably more if you add the layout id)

johannes

--=-mBtoMAvMcUfr+rKqrOZs
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARCPZ9KVg1VMiehFYAQJaVw//XIQH/XasJA3xbK/UQZx7Hs0PVDRTKxhc
3uE7q3Z5ZkBH3858ZFoRVxKJrU7fa6YRTpWJHJ2Ad+MOpI0JAQ4MUvKwnx3+QjOL
3aN+0Z1hA9na17FU/UmIIc4xcsqEIe0YkBICY91l3pdXi3I+2RsENNc4KTlbraQB
oNcDgjx6NtRL3Mlv6IzoLPlyL/W8Sc1+qsmRD1hwLztNvQhLszPPeK+LeecPT9zC
R81U35PD6/RRCVZ2Syjw2VTr790JxqhyCagwnVLjmrgFIx/aqbbwj3iA95eWLKU7
lcOilypPMkB1MnT7Hwocy9SUhXa2dBjRrQSTiSqJHm3gqPCIl/xCCWFW2b9kJEPh
Qko+n0nehKkEPtDxp9hrz0nd4F2IQy4XSqAh4nZ2NckSnJLEsrIRGl3H/QmzYK5K
LIrTXiUbEYFPqAwJtDSfRtKvHXBt1zeadNj9JkHM5t81KV3Wn6fTjKq0oKbEquDt
0Q1WHvYKRdzuTBP2hBR6feWBvJgkwd26ZbX4WQD3k6v4LH5jq0ih/J3oiCLuqkW/
efuZ9EJzdpTaWG2Git+8Pe/a330oQh7ID7Jfiqrd3nnul/VGX9n14nxKdF6s8DQT
7GmRLZIytlVHqnrDuz2pTUdAi3GfotAcLZU7m8ILkRAUse7R52SkF8BHcI8Xp0ej
E+NooVxxH6Y=
=5+QP
-----END PGP SIGNATURE-----

--=-mBtoMAvMcUfr+rKqrOZs--
