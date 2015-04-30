Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 209301A0C30
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 17:11:04 +1000 (AEST)
Date: Thu, 30 Apr 2015 16:58:21 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v9 30/32] vfio: powerpc/spapr: Use 32bit DMA
 window properties from table_group
Message-ID: <20150430065821.GC24886@voom.redhat.com>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-31-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
In-Reply-To: <1429964096-11524-31-git-send-email-aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2015 at 10:14:54PM +1000, Alexey Kardashevskiy wrote:
> A table group might not have a table but it always has the default 32bit
> window parameters so use these.
>=20
> No change in behavior is expected.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

It would be easier to review if you took this and the parts of the
earlier patch which add the tce32_* fields to table_group and roll
them up on their own.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVQdKNAAoJEGw4ysog2bOS8MEP/00wlh2y23OviYIkIzRiFLyP
qwEeKCHfK/xnTbxSvNnmlaqDOdACACso+UcTkHIB+7nHnpGf4i+yVX9LEsdx2tnk
qQu3IXs5HOAPoYHRbcucv6qNVOnRpU8F2esKMG0qmWqKSydswVEFlgnB+Ur0xeTr
SiY0xF1yXIedq/Gow2be0Obu31CwuUlAOpMvxWrgMb968IPz0m1MkafLDypXawt1
P5UPdbDHhMii9pnhjLkqHEx3S1hRMTTE1o6lmhlAF9RRVgnnSEx2vTm971zPjJCc
3GdL/YHN9Qxyoq0lz1QGnnh/MD/6TnE9/porGIVxADN/7b0FXBphY32srsulTXsx
AID8M5FX1057OgukIps2Cwdlc8RRua+OF6gCmM1rKlOClfakqYdqtWBtMsZyhiBD
34aimR221fmZC5DR9Qt6B2YWPLICR6UiX0M9iJ1WTP0/Fdwoa0SIxlTxKd4GImxu
sEXqPAm37MxvZ0HvB69LnSR1sk+4XsEXFjPs/iYpjaaOT94s6JFD5ck1yA2DpLqa
30kGrx6s8LQVP8B2u4hYgT2DSbwcIjtZ+UwXVDBrMhqqsUcw2ylPydNaJFdGDBZ/
bYtcyCLM2TVWD3fEvJGVPz8jeBhg/elWR/wfCG746bOeMbovUHSCAY1fVd8pDEcB
9GrqTUOKusKLfmzj4bK2
=g4JU
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--
