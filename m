Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4AE5D1A0ABD
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Feb 2015 06:36:22 +1100 (AEDT)
Date: Thu, 5 Feb 2015 20:36:13 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Amit Tomar <Amit.Tomar@freescale.com>
Subject: Re: [PATCH] i2c/mpc: Fix ISR return value
Message-ID: <20150205193612.GG15307@katana>
References: <BL2PR03MB449C87445D2FD1F15E9D33483310@BL2PR03MB449.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="vSsTm1kUtxIHoa7M"
In-Reply-To: <BL2PR03MB449C87445D2FD1F15E9D33483310@BL2PR03MB449.namprd03.prod.outlook.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--vSsTm1kUtxIHoa7M
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2015 at 10:24:10AM +0000, Amit Tomar wrote:
> ISR should not return IRQ_HANDLED for not handling anything.=20
> This patch fixes the return value of ISR for the same case.
>=20
>=20
> Signed-off-by: Amit Singh Tomar <amit.tomar@freescale.com>

I can't apply the patch. There seem to be whitespace problems. Please
fix the patch or your mail sending.


> ---
> drivers/i2c/busses/i2c-mpc.c |=C2=A0=C2=A0=C2=A0 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c =
index 0edf630..7a3136f 100644
> --- a/drivers/i2c/busses/i2c-mpc.c
> +++ b/drivers/i2c/busses/i2c-mpc.c
> @@ -95,8 +95,9 @@ static irqreturn_t mpc_i2c_isr(int irq, void *dev_id)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i2c->interrupt =3D readb(i2c->=
base + MPC_I2C_SR);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 writeb(0, i2c->base + MPC_I2C_=
SR);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wake_up(&i2c->queue);
> +=C2=A0=C2=A0 =C2=A0=C2=A0  return IRQ_HANDLED;
> =C2=A0=C2=A0=C2=A0 }
> -=C2=A0 return IRQ_HANDLED;
> + =C2=A0return IRQ_NONE;
> }
>=20
> /* Sometimes 9th clock pulse isn't generated, and slave doesn't release
> --
> 1.7.9.5
> =20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--vSsTm1kUtxIHoa7M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU08YsAAoJEBQN5MwUoCm2j+IP/0frGE2bdyzVHfXb35oq9vEo
vjLWjehWry2xBO1Hs/E4OzNwjB4Kr4YUFjZ718XdLVtFjfiyGFPPv/ec6B70TbTx
Wj9Lysrn546cfkmmThxjURaZrEzPh3qoZcqrcF5N3ekZ1mC1mRlzpDS4fIdnzMXU
WPgl2LoLUdTySJH5Z2vWrCS65UdfVu/fJz5JTHKmo3AzugOpsSVOPu0hhj+lSqwT
XYHgHxm9Gz6VBucleB7NMfxKBPbpDdieQq262C0sH82dkjd65FVZ6LdykXLrEAYP
n+D/rSt4d2YQc0g16cBM56dror1IYl0hmLlL3Y74AkAEyjK3A+YqR9trW7AlpKcU
CpYcJhJUdRXRte5U9YuKMq9UPi1ls5AfO1IF3sLPtumHXgoEgjYfs5OrTDf/Zai+
2Xb24HzBr54/TM0yI8S3Cgp1+fEjUs0YTo8NvjBK/aBkqgkxtmVK7E+LBVfdOehH
V/fN2d2uG8AspK+UmxeyVSFO0bkGWdBepvHCN5eiEx3KzsverxfM9lao8noNK8IE
dk14GAol5cQSj7eaOYV9TGn8kT9PdZ2YfBdcQjzvIVsYm5s5LFyYqUXj0KHxpqFE
MtEzOQQG3wNB/7PpgPnekaqzNXTLAM0w9lH8C4F6th+0rpJWfnDerxOIbjZytMqb
P8xfj32mFaNcbNsrhvU9
=cojz
-----END PGP SIGNATURE-----

--vSsTm1kUtxIHoa7M--
