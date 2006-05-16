Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 29BD0679E2
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 00:56:30 +1000 (EST)
Subject: Re: [Alsa-devel] [RFC] alsa integer control ranges
From: Johannes Berg <johannes@sipsolutions.net>
To: Lee Revell <rlrevell@joe-job.com>
In-Reply-To: <1147791186.13948.109.camel@mindpipe>
References: <1147780945.29795.110.camel@johannes>
	<1147791186.13948.109.camel@mindpipe>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-ouoR/w+Ko5EVP3wp6JwD"
Date: Tue, 16 May 2006 16:55:15 +0200
Message-Id: <1147791315.983.21.camel@johannes>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	ALSA development <alsa-devel@alsa-project.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-ouoR/w+Ko5EVP3wp6JwD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-05-16 at 10:53 -0400, Lee Revell wrote:

> Ummm... what problem is this patch fixing?

The problems that
(a) kmix, gnome-alsamixer, gnome-volume-control and others can't
    properly use the playback volume control because it has a range
    that doesn't start at 0
and
(b) alsamixer can't properly control the capture volume control for
    apparently the same reason

johannes

--=-ouoR/w+Ko5EVP3wp6JwD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARGnn0KVg1VMiehFYAQKRqQ/+IaFDH4aceQti8Y+Cz/4KgEx/LF/kbTq0
TBoCbo5uVMVuGKwzjAgPPnUtneek1SMT8scPKIQjiMyqcj9AXoofBPLwFhIpnDqJ
eiEiJsJorqlJUDSaCGtlCo+Jg5yTWoU8KQlomE3YgpxOcgEOzETRcggIFkToPlf0
jI5vSaFsMFcEZEzofe5dGwOQBFVlg4sJ4crbFg663q4PWJwrxmshueyBc84bI4d7
CqTyRpoX1fjCspfkKjX4eft/pvG+xgNqygQ4RuvjCE0DThI8aIrTRvv/nFuHIpJQ
F5mXEI9DL1YWXZ6bNuXSbdh3RW/AnESB5CdLk7bN/FOvBl3WFYfbhqDk4rXFTvVc
V1am7t1VFfzj0onZJyVM4NatS/ZMAsW3ZUA1r9jK80NwAIgufmJFVHCTTxMJd1om
W3LF2w2eXrDoudC+sgRIVEPkvOBvshWkPtc9BacdslYw6wSJGgPRWC5Hs8Eoa0Lo
OryBaA3U9NOCQNnIyr/rYKlPqCR1oa64JMFt+zN2hOvNwzFRPBYKcq1Qt7Q47Yc4
KbF0EvOJ9fh0yTR/675G7LVoCBqbZohMEZJ794xJnhRMfbaEm7iAx9SQ6Vo0QbCe
3Oab6C8VWpO3e28GK1MFV02QBHPgzA4zywYQZXNoQ5sweC+hmyBupYU7XVdJ2pyK
x6m+tWhMI6w=
=QplL
-----END PGP SIGNATURE-----

--=-ouoR/w+Ko5EVP3wp6JwD--
