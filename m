Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 03C1E1A001E
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Aug 2015 02:34:53 +1000 (AEST)
Date: Fri, 7 Aug 2015 18:10:55 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 Jean Delvare <jdelvare@suse.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Michael Neuling <mikey@neuling.org>, Arnd Bergmann <arnd@arndb.de>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] misc: remove boundary checks from bin attr users
Message-ID: <20150807161055.GD25357@katana>
References: <1437945502-27944-1-git-send-email-vz@mleia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="wULyF7TL5taEdwHz"
In-Reply-To: <1437945502-27944-1-git-send-email-vz@mleia.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--wULyF7TL5taEdwHz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Vladimir,

On Mon, Jul 27, 2015 at 12:18:22AM +0300, Vladimir Zapolskiy wrote:
> This change removes a number of redundant checks on bin attribute
> client's side, the same checks are done by sysfs_kf_bin_read() or
> sysfs_kf_bin_write() caller from fs/sysfs/file.c.
>=20
> Note, drivers/misc/pch_phub.c and drivers/misc/c2port/core.c may be
> updated in a similar way, however this task is not done due to more
> complicated read()/write() callbacks.

Can you resend the patches which touch i2c drivers with me on cc? I'd
like to take care of them.

Thanks,

   Wolfram


--wULyF7TL5taEdwHz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVxNiPAAoJEBQN5MwUoCm2WZUP/RpeKlzxg8sa83oU8h6AEP+w
tlkv3VRwta2HNDY10+UjMDEEa7vfOZvgC4ZtXQolVZM/nDT/8WPeWpYAfNiqD15U
8y1Nn9trDPUq1z9BB6RkOFdSxztECQ+/tJmArtme1nqPuN5phzjQmHAWpKDv+5Aj
uTwc6mMyC9Dp01gSd107KzzMe6QHo8hd64ztv2YklKkIcUj68nuC68WWSLWZGkw4
pv2Fk3eRjK8uqiafGyfUY5DVqUHuxpymm3+CN9yAdMR48lQjCC5+k5g+OnQmTr2k
n8GLZpKXT6ejPq4fqb6iUoppAKP5/WoGzRdQRbgvI6htZBPiQpS7Srl5Qi8hZeGS
gjfDsB7+TDDbT+BpOKNLBKjKCvgUL098vXwYllY7XN5iIkR+HApLPxFhH98lhvUs
inZebC/xCNHK5qQvuv/rxzfuavJsjnNICuHbc0HIBJ0H9Ed4FxDM7Dy6PTGUWOvo
2/tVH07oCIs5A9BrI/5jvBlzcGG+tPzFaBE9VPvfBYHo+lm4SCGJslnWzRYCHv3s
acgNpw7NzxYbkbLWHH+hD7JJlPHuWqoZZkz7Yi9mnD8Mnjb+tD2oHlVtDD73/qPD
NPzd6kDGIWmtqU+8XB+55B+tjn/yHJBGpny8vEjyt7OAw2x8jE5Pvaq8wZ3O2U25
LKaa+AJ/jAfZ6bN1FGKv
=ptiU
-----END PGP SIGNATURE-----

--wULyF7TL5taEdwHz--
