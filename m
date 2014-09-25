Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 56E1F1A001D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 17:02:08 +1000 (EST)
Date: Thu, 25 Sep 2014 17:01:59 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Cyril Bur <cyril.bur@au1.ibm.com>
Subject: Re: [PATCH v2 1/3] drivers/of: add of_changeset_apply_locked
Message-ID: <20140925170159.1b7e4521@canb.auug.org.au>
In-Reply-To: <1411627290-20302-2-git-send-email-cyril.bur@au1.ibm.com>
References: <1411627290-20302-1-git-send-email-cyril.bur@au1.ibm.com>
 <1411627290-20302-2-git-send-email-cyril.bur@au1.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/GnfRfmQFOUmrqLZsgF54Ct4"; protocol="application/pgp-signature"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/GnfRfmQFOUmrqLZsgF54Ct4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Cyril,

Nit:

On Thu, 25 Sep 2014 16:41:28 +1000 Cyril Bur <cyril.bur@au1.ibm.com> wrote:
>
> Due to the requirement of of_changesets that of_changeset_apply be called
> holding the of_mutex and that the of_mutex cannot be accessed nicely outs=
ide
> the of code, added a wrapper which grabs the lock and called
                                                        ^^^^^^
calls

> of_changeset_apply.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/GnfRfmQFOUmrqLZsgF54Ct4
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJUI73sAAoJEMDTa8Ir7ZwV+PwP+QG8bJxmOChv+me+96gEyE7t
Fq9Dd5oHAiTRpvQ96P3tLl7gIac1BLCP5JJxqz1FXEShYyQYyPtWRloFmUExl5p9
0DYGAlHP/ggG0CMhUnK7lD8kEdXeOa/tNKrRzjAQNvWhgkd3DRUT8vvwYyngESNh
MEFS2FMh0+FwEzDTTPR86a/J7SIF3Ijk9xZApj8LqdNAJwg7Uilklwiddab5Oai/
4LaGqg5sM5Pr9HRf8pGhBdSkqklM8FD3Tk8pg/xy2yTIcMd62p5iUe/jTQcWy+Ux
gGz4vrQhAnMmt86tYLbM3auJbzSn5T0cewHbc0+feHQS2pj8cIJjHAwUf4DMjYw3
z4CffT7wsl31/F+2iDplly4Je+hGIC1TZneDvPViRYk5P7PMMJaNckU+o1XN6S88
0n+nYIG/4D/qqeWzps68sFl8NlnjB/zVkzhPzGHB2o+k3F3LNgdaullMGNDe4u6b
Q0NP7yEQuiexcuh59q5Q57J4w4I9JNBUe73TfmEf5V/aRQeOki5b1hAjjAacz22f
pSBkQWF0DqrxdwC2i4lQa1HBC0ZvIuiv3BQ9upKqczSQNKaqf3knIvBLCx2dDXsa
qSaAyw2PR0Hg+YXC42zxQ0uvZT2IDxUwiHtRBcXOPcA5FoEOvYyKR4QS1ZfC4/nC
9cgGzKnv0P/dMGtKzsLj
=uHMc
-----END PGP SIGNATURE-----

--Sig_/GnfRfmQFOUmrqLZsgF54Ct4--
