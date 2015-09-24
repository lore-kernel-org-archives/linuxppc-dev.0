Return-Path: <tomi.valkeinen@ti.com>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 935961A0026
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 20:18:49 +1000 (AEST)
Subject: Re: [PATCH v2] video: fbdev: fsl: Fix the sleep function for FSL DIU
 module
To: Wang Dongsheng <Dongsheng.Wang@freescale.com>
References: <1439531649-46827-1-git-send-email-dongsheng.wang@freescale.com>
 <55CEB5CB.4060803@tabi.org>
 <SN1PR0301MB1616D30A83E8A5C6FEE6A44A9D430@SN1PR0301MB1616.namprd03.prod.outlook.com>
CC: Scott Wood <scottwood@freescale.com>, Jin Jason <Jason.Jin@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Timur Tabi
 <timur@tabi.org>
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <5603CB53.6070403@ti.com>
Date: Thu, 24 Sep 2015 13:07:15 +0300
MIME-Version: 1.0
In-Reply-To: <SN1PR0301MB1616D30A83E8A5C6FEE6A44A9D430@SN1PR0301MB1616.namprd03.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XMmgglBKvwIfDkudiTBGnDL7DRpGR8pOA"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--XMmgglBKvwIfDkudiTBGnDL7DRpGR8pOA
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 24/09/15 13:02, Wang Dongsheng wrote:
> Hi Tomi,
>=20
> Could you apply this patch?
>=20
>>> For deep sleep, the diu module will power off, when wake up from the
>>> deep sleep, the registers need to be reinitialized.
>>>
>>> Signed-off-by: Jason Jin<Jason.Jin@freescale.com>
>>> Signed-off-by: Wang Dongsheng<dongsheng.wang@freescale.com>
>>
>> Acked-by: Timur Tabi <timur@tabi.org>

Thanks, queued for 4.3 fixes.

 Tomi


--XMmgglBKvwIfDkudiTBGnDL7DRpGR8pOA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWA8tTAAoJEPo9qoy8lh710kcP/2RtVyXoDsZcRCdvw/W/wXk+
fwfduxriYyRd4PO8GUmhl9v5m1N2wzjqTUNEus13FexwZyPxZQ/nVYmUx9Ui9nuL
LncUYtuvpRxJ+QwVbac2qCEZ7EMJnNsmGtdCDz60S8Uej/pXP/SwL6OoSS5Wq+vp
KwQK3Zk0STxJWceZdUfm/0WyyxglzP4w9oV2Tg3j/dcQLG4KwVmO7d3gKl1We17r
l+lN61UF0SgBNIKAi2ucVSb5rlARKK/uceoBTiGZ2pHZvObJEPuLJQuwyE9wpJpm
UcHDedAYQq8unmKLHDScbc/jMQMVoSQsheKAg9G5QI8UIxA8YWfnRwTrj5gxHUDU
VmRMAHe58WJCFDBTL72D1dSd2XGqs0hg41kqzv27WXysbzQNe/Hx3nATkVpWQ5vy
bIceWvbg4su5vCTkmD5Enyt2LcJ9eUTIf9Fw3i7mXJmGciU7leysF1XAaJinkmI9
KJgYzkG2KmkifNadH1vT+iliG/lbkOxJgcQBBNQEjzsDdngej8ZADp6bS+Y+OTVC
vnXcAm7QvdkH4cJwAYX1vX06LMyK98DwHjQMh5+xWpU80/0G1XEEmgt2x+sOhXCm
QOfCs/U/vnRwLzkqT9bzEVTZOTwAiH78K7mM4oRStdEB4SndO+lSsu/o/c/MtR9v
GHe+qZkpZcbbLmWptTQf
=7LuS
-----END PGP SIGNATURE-----

--XMmgglBKvwIfDkudiTBGnDL7DRpGR8pOA--
