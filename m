Return-Path: <James.Hogan@imgtec.com>
Received: from multi.imgtec.com (multi.imgtec.com [194.200.65.239])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "*.imgtec.com",
 Issuer "DigiCert High Assurance CA-3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 78C672C0322
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2013 23:04:47 +1100 (EST)
Message-ID: <511A2FC2.7010909@imgtec.com>
Date: Tue, 12 Feb 2013 12:04:18 +0000
From: James Hogan <james.hogan@imgtec.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] Centralise CONFIG_ARCH_NO_VIRT_TO_BUS
References: <ADE657CA350FB648AAC2C43247A983F00206B25884B1@AUSP01VMBX24.collaborationhost.net>
 <CAErSpo6WG2R_8sa=rOmAOci-3iFpDs2NFzNkZYxDnD2oTiMQJg@mail.gmail.com>
 <20121113082615.2f482eb8835daf46e1f27947@canb.auug.org.au>
 <5118DCA8.1030905@imgtec.com>
 <20130212154010.3f8b88da4756c7cf04e28a04@canb.auug.org.au>
 <20130212224729.5e60d0303bda923bebcc1185@canb.auug.org.au>
In-Reply-To: <20130212224729.5e60d0303bda923bebcc1185@canb.auug.org.au>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCD18698F87994248FE52F0D9"
Cc: linux-arch@vger.kernel.org, linux-sh@vger.kernel.org,
 Vineet Gupta <Vineet.Gupta1@synopsys.com>, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org,
 Paul Mundt <lethal@linux-sh.org>, Paul Mackerras <paulus@samba.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org,
 H Hartley Sweeten <hartleys@visionengravers.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--------------enigCD18698F87994248FE52F0D9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/02/13 11:47, Stephen Rothwell wrote:
> Change it to CONFIG_HAVE_VIRT_TO_BUS and set it in all architecures

nit: typo in "architecures"

> that already provide virt_to_bus().
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Reviewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James


--------------enigCD18698F87994248FE52F0D9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)

iQIcBAEBAgAGBQJRGi/CAAoJEKHZs+irPybfbLoQAJcwSYD3NK1dOp1OC8OUY4tF
SA0WEPGCHUY0ewKfTfJAxzxeiKBL0/v0EigmMktkMmg/BauiT/75q4/EG8SxjnD7
Tf/pZ0IlTU9xM5dYeqSNEeimxZv8gXp5DEJ56+UV8pSZ0PhtNowKCTnePA71DtO6
mFNYP9GcjSxNYHfYTzHxLEhp0xfSTVWrOpW0ak+y97XMQOS3Yxff8wSizq7LhBcG
H+t5J8paEWs73BJsZKzVtkdDyp4Tv5shjHhl4TeGv7doxcYykX5yIlWxgZLFRRI+
3o1JACl75gmFDxGi/2cYK+mkp24SupVYNGw/teRrsKGOoGO6k30XLG3COlYQCSOb
mslGyP1DFryONBNcRJ3gT8dkyv9zsoL0vwMj6TN1e36MnAAlKoAnziJZ/kpscR4F
IOuEPBtOjothoEgA9e+X/BdkGBh3kLztZvFE72wWYIX/r9+ynrWi85SZDcxMG/o+
f/uvRaOIRI5E8nPyapat75veiw7GWNl5ZxvCRzHl8e1xEWUb/PWlJma+fd7sAZLn
fFlCPQ53QG//t2t1Y6OjiNbzOJsj+1yMI/EHULbeSVALUyvYPzaH+yfCvHwIBNTx
vbb0JQKEB+syLW5QNYIBOpBCkyMYrEW+TUHj3MUIXJ2JZgB6e9P+HUKwQXb7PW4F
6gotw7qwQEz9aNx36fBk
=69Xu
-----END PGP SIGNATURE-----

--------------enigCD18698F87994248FE52F0D9--
