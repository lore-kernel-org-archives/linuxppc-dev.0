Return-Path: <haokexin@gmail.com>
Received: from mail-qc0-x22d.google.com (mail-qc0-x22d.google.com
 [IPv6:2607:f8b0:400d:c01::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1E2961A051E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 17:00:04 +1100 (AEDT)
Received: by qcvp6 with SMTP id p6so24275338qcv.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 23:00:01 -0700 (PDT)
Date: Fri, 13 Mar 2015 13:59:53 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC] powerpc: use ticket spin lock for !CONFIG_PPC_SPLPAR
Message-ID: <20150313055953.GB24485@pek-khao-d1.corp.ad.wrs.com>
References: <1426157723-28548-1-git-send-email-haokexin@gmail.com>
 <1426158807.17565.131.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
In-Reply-To: <1426158807.17565.131.camel@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2015 at 10:13:27PM +1100, Benjamin Herrenschmidt wrote:
> I would do the ifdef'ing differently, something like
>=20
> CONFIG_PPC_HAS_LOCK_OWNER
>=20
> CONFIG_PPC_TICKET_LOCKS depends on !PPC_HAS_LOCK_OWNER
>=20
> and use these two in the code... with SPLPAR select'ing HAS_LOCK_OWNER

OK, will do.

Thanks,
Kevin

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJVAnzZAAoJEJNY7TDerrFxhlIH/j+ssYqgvyIhTaay9WkOq/vz
BRyElBsJSHm1Z39Y2tOK+4eZgAyRKjrMq1eox5J7U3fFk4bhciYbnzSc23kirBXA
xdEgbKYFDOCrZzikjkTuLbP3g0ur8bEFi+CD0cF4V6osC9SABiriJL1TK/T90l0N
9HBxg/Lfsg7Q4nxWQB2pkwGxTfvFFj+q2XUDqEbajrR0sMY3oSEG0OAr2ojkZEFq
xSZr8MWlXuDe5wR278Of78dUapv03VFpiZjxSUqpuCVfFVpHArc6W8II2BASQ1kS
M8gFhdsmGIkWOqejmhvZj1Cx4J7jcSzsmCjKz2x+ziTvaN+6NMfLrK26sLwX+U8=
=3DkP
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
