Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 91BB92C009B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jan 2014 23:54:48 +1100 (EST)
Date: Fri, 10 Jan 2014 12:52:31 +0000
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Message-ID: <20140110125231.GK29039@sirena.org.uk>
References: <1389347646-20432-1-git-send-email-Guangyu.Chen@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="VJJoKLVEFXdmHQwR"
In-Reply-To: <1389347646-20432-1-git-send-email-Guangyu.Chen@freescale.com>
Subject: Re: [PATCH v3] ASoC: fsl_esai: Add ESAI CPU DAI driver
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, shawn.guo@linaro.org, pawel.moll@arm.com,
 ijc+devicetree@hellion.org.uk, tiwai@suse.de, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, timur@tabi.org, lgirdwood@gmail.com,
 robh+dt@kernel.org, rob@landley.net, galak@codeaurora.org,
 grant.likely@linaro.org, perex@perex.cz, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--VJJoKLVEFXdmHQwR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 10, 2014 at 05:54:06PM +0800, Nicolin Chen wrote:
> This patch implements a device-tree-only CPU DAI driver for Freescale ESAI
> controller that supports:

Applied, thanks.

--VJJoKLVEFXdmHQwR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSz+0LAAoJELSic+t+oim91akP/2mtB/1hNpiDcevh1qECfDrT
EbvzZIEfN5bJQCjSsA1j4uv/2wz7u3teazfK1SmQHcBv7IF6McpQktdZD5KaP0LO
sXmV3o6qCfm7ZflKt2fjU2CtnVO1/PFwxfdNhxG+BZ7n8IqwW7EF/Oyvg0a8FAbx
jI9wxpur/hnqBbQGCi+g/NZ5RFouoH9EJ6W2YnSuCqMT/h/ifTX2gjf0GLlDJ/ip
Q0fqFfwZPaxFJzUQrEHl7THfEr9MkZswgD6eY8a/bw9Nb5R3a6d1TsToFipco6Zl
XedQyIBU33hgbq/l471+YH3RtNNQW2PTYP75+Aj1glQxxY0n1MplF7A06obKnBpe
f9m2WD+6j1fVX0nQVsLXpdN5mcKTk1H0NumOWqi+CQpk9ZYivupXNoKDdq8pk+bX
DRaQ0yGuheuPCr9BSnK20c1PRnPRwgpaqBfhbd4vZHiuIZFH+TMFz2q2w6IXnE4z
NDuLj2oAy6BNGb0hCK9FVXXmHnGCKdXaugVoWkp8EG47D2DI2D4sU2Cx1Y/kzbot
U54pvApJaKaADtFyAm2Z0t1GzCN1TgmAsJa4K1J/tF3S7/0IrD49XzGGQtPB5QP5
3ZvYG9iemHZoEfJiPzhQQZRCHCO6WCEuLgqFRMk3p75ZAx3FYxdv3XCRH6FMgR11
JA6UEdXSAb+Gl9OMKVLX
=yaEU
-----END PGP SIGNATURE-----

--VJJoKLVEFXdmHQwR--
