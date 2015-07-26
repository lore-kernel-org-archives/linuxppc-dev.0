Return-Path: <dja@axtens.net>
Received: from mail-pa0-x22b.google.com (mail-pa0-x22b.google.com
 [IPv6:2607:f8b0:400e:c03::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 004341A036E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2015 09:08:12 +1000 (AEST)
Received: by pachj5 with SMTP id hj5so40883083pac.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2015 16:08:10 -0700 (PDT)
Message-ID: <1437951966.6262.3.camel@axtens.net>
Subject: Re: [PATCH 1/8] misc: cxl: clean up afu_read_config()
From: Daniel Axtens <dja@axtens.net>
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michael Neuling
 <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Ian Munsie <imunsie@au1.ibm.com>
Date: Mon, 27 Jul 2015 09:06:06 +1000
In-Reply-To: <1437945533-27996-1-git-send-email-vz@mleia.com>
References: <1437945502-27944-1-git-send-email-vz@mleia.com>
 <1437945533-27996-1-git-send-email-vz@mleia.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-D9zqCHhwTF4rxmkG8/GG"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-D9zqCHhwTF4rxmkG8/GG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Reviewed-by: Daniel Axtens <dja@axtens.net>

FWIW, Ian is on leave for 2 weeks and Mikey for 1 week. However, as one
of the other CXL developers I'm very happy for this patch to go in.

Regards,
Daniel

On Mon, 2015-07-27 at 00:18 +0300, Vladimir Zapolskiy wrote:
> The sanity checks for overflow are not needed, because this is done on
> caller side in fs/sysfs/file.c
>=20
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Ian Munsie <imunsie@au1.ibm.com>
> Cc: Michael Neuling <mikey@neuling.org>
> ---
>  drivers/misc/cxl/sysfs.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>=20
> diff --git a/drivers/misc/cxl/sysfs.c b/drivers/misc/cxl/sysfs.c
> index 31f38bc..87cd747 100644
> --- a/drivers/misc/cxl/sysfs.c
> +++ b/drivers/misc/cxl/sysfs.c
> @@ -443,12 +443,7 @@ static ssize_t afu_read_config(struct file *filp, st=
ruct kobject *kobj,
>  	struct afu_config_record *cr =3D to_cr(kobj);
>  	struct cxl_afu *afu =3D to_cxl_afu(container_of(kobj->parent, struct de=
vice, kobj));
> =20
> -	u64 i, j, val, size =3D afu->crs_len;
> -
> -	if (off > size)
> -		return 0;
> -	if (off + count > size)
> -		count =3D size - off;
> +	u64 i, j, val;
> =20
>  	for (i =3D 0; i < count;) {
>  		val =3D cxl_afu_cr_read64(afu, cr->cr, off & ~0x7);


--=-D9zqCHhwTF4rxmkG8/GG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCgAGBQJVtWfnAAoJEPC3R3P2I92FTVoP/RUopov9Rq2zPs14JIsMrGbv
GDGNAWxCoKeHopeMTttENPItWAIeUx26NWaqY1T/XSbUcx91h0WCz1Ww/7yoQz5K
WYqMgguSawrGR0Sy43yAc6gQM1C+D8n2ow+7i+b5D1bQp7FZGAHkaNdLNXuHHNlU
QT2zymKINVfulXrxI6d+du/1QWjDkvum23N8rxRS9fGDfAztqoI3bacpuD7V9G+F
YPtoryi94HDwFXTPqbRxElCsDnVaQYjzIzlcdO+24n3UGpwzaIrJEQ8RH/fA3tDX
WrSioaVpGs3zBz1XBXRP8CAFdKfSuduVSjVhahL530QXWmcQQLwHap9JD8o8w9xX
EcdM5FeMhTBcBMDmt5gGsh/J0E9FieDGtHgh8ZaRqIVHs4AEiR40SDXg9/5eizdn
b62FAqjj9bRFti6sFaz+O1i11IJzcDhGaFWsIpQFavkLtT9hGvogSdqTJUHuTKTc
ezwxjI992CCQ85i5OC4rDvEqI8NwfNgmUo3Xy6KwQRVUEwBlYxxC8I1XRDu/JyIA
m+jUyV6DEU3QZ9WVL99Qq4dN/u4qA+PZt3nA6RbR98XW7A1ktt03I+LbsHYCdftU
XIILkSyIi5bCnvjwYmEjIdei8gPYU/eN4yPj5rgoxxLyXUomQQ6uNDY5YlB6f4uZ
zweaO8gS3OJyXisiybtG
=UOzo
-----END PGP SIGNATURE-----

--=-D9zqCHhwTF4rxmkG8/GG--
