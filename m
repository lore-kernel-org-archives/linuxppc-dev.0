Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5F2F6DDF6C
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 23:07:26 +1000 (EST)
Subject: Re: [PATCH] fix appletouch geyser 1 breakage
From: Johannes Berg <johannes@sipsolutions.net>
To: Dmitry Torokhov <dtor@mail.ru>
In-Reply-To: <1193222676.4510.5.camel@johannes.berg>
References: <1193222676.4510.5.camel@johannes.berg>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-qeFqCmq+tlE3KGLshwOP"
Date: Wed, 24 Oct 2007 13:22:22 +0200
Message-Id: <1193224942.4510.9.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Anton Ekblad <valderman@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-qeFqCmq+tlE3KGLshwOP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-10-24 at 12:44 +0200, Johannes Berg wrote:
> The patch 46249ea60fbb61a72ee6929b831b1f3e6865f024 was obviously done
> without testing on a Geyser 1, and I'm a very annoyed that it was
> applied. It causes appletouch to continuously printk:

I spoke too soon, I don't have a Geyser 1 but rather a Fountain touchpad
on my powerbook.

johannes

--=-qeFqCmq+tlE3KGLshwOP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARx8q7aVg1VMiehFYAQJeng//bLB1qfVTr8ZTZu3b8vQqig95FYOlw5Xn
riuTi9jNlczsHoxSep7xXk8KDRozivmu4Z2e+QkweJeDktkYpiDOW7ybcnO9tde9
hJM0HTW0gXr1Y2o40B1obRHD7OAR3hbaEMUvYLBkv4ESlrxAIcundn9uIMjFOhBt
8+GO76VHCSdNACXUMHha8GgbBIWEYK7iOWuZSYE0UJAfoNTr/01kwPQBUuHAa3Zm
nzC6qFjhDylMJQyhq2VhHcGHjg2bqcM3vRZtBaS3+ETIxXHBkk4mOmm+5GWHtjTB
NR8eyYPSt1nv6PWR8oIuqphP72Tu/QqyWHG9TcKLbWI4SfsYfzCIRFPDJkccfg4B
vno9QA6KdLUsDNvQUvCbBmGGR5cnm//zG+QmfhYWFtllAFmumPZl8IN3El+wfWy6
pE+Ct2HC30tpRz3WjEOOPphKveNAOkGWQFLn0j4EeSad2T3hQ63Bjd81wYSuwDoD
g0DQ3/o2FACHLizcwIwtsPEU5omnvygOHQBvmzp3orvkrcjMSLJn4nPGQvBulDHh
3/Ej46KPW2yRPj9ZLJq0W+YRVCqUFeTS91hX75FK8HL6mceIqit2fVFGGkhc/ivN
732dmPoztAGAFBFu+dqhIJodVYoHiqmvtT/0vZNB2kSNYWyaSuSeiDm1RaDFV9qT
tTDG445rRxM=
=t3gc
-----END PGP SIGNATURE-----

--=-qeFqCmq+tlE3KGLshwOP--
