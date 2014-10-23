Return-Path: <tomi.valkeinen@ti.com>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 361F21A003F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Oct 2014 22:39:43 +1100 (AEDT)
Message-ID: <5448E8CE.7040405@ti.com>
Date: Thu, 23 Oct 2014 14:38:54 +0300
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
MIME-Version: 1.0
To: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drivers: depend on instead of select
 BACKLIGHT_CLASS_DEVICE and ACPI_VIDEO
References: <1413580403-16225-1-git-send-email-jani.nikula@intel.com>
 <54476492.6090105@ti.com> <20141023081034.GA26941@phenom.ffwll.local>
In-Reply-To: <20141023081034.GA26941@phenom.ffwll.local>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Nn26dT9qtJTf6VjBixu4iLbwGnd55SpBm"
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 linux-fbdev@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>,
 Daniel Drake <dsd@laptop.org>, Jens Frederich <jfrederich@gmail.com>,
 Jani Nikula <jani.nikula@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jon Nettleton <jon.nettleton@gmail.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 platform-driver-x86@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
 Randy Dunlap <rdunlap@infradead.org>, Daniel Vetter <daniel.vetter@intel.com>,
 Darren Hart <dvhart@infradead.org>, Bryan Wu <cooloney@gmail.com>,
 linuxppc-dev@lists.ozlabs.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Nn26dT9qtJTf6VjBixu4iLbwGnd55SpBm
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 23/10/14 11:10, Daniel Vetter wrote:

> If we want to make BACKLIGHT_CLASS_DEVICE into a library thing then I
> guess we could do that, but we must then also drag it out of all the ot=
her
> meta options to make sure it's always available. No need I think to dit=
ch

BACKLIGHT_CLASS_DEVICE only depends on HAS_IOMEM and
BACKLIGHT_LCD_SUPPORT so there are no other meta options to avoid.
HAS_IOMEM comes from drivers/video/Kconfig's "Graphics support", and I
guess we can ignore it.

> the entire BACKLIGHT_LCD_SUPPORT meta option. And then everyone could
> select it.

I don't quite understand what purpose does BACKLIGHT_LCD_SUPPORT serve.
It doesn't enable any code, it just opens up new Kconfig options. Why
can't the Kconfig options be always available? It's just another option
to 'select', without any reason I can see.

 Tomi



--Nn26dT9qtJTf6VjBixu4iLbwGnd55SpBm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUSOjOAAoJEPo9qoy8lh71ZtAP/R0WADvDaKCQZijK3sTtHI9a
Ic7QSu772o5C2vybbt3iKEM7NA4mugQJJnvnN/SOyLpKmA8T0RWAJyhV9QYpp/UC
a3/ULiGv7AB/I5V+GJUrsUevFTCdConhYDlXN4K2Q9r7aOYv41xiQkLfxb9LEy5t
4NcrIDU+ycG/aqlXGbroVz3DV9PMVhbiRjFgxR92VCReXeoJ/zh6P2oIOAEWtdL5
D2CK82WYO6EqVF1/RAeUA1k1XRHYFe3ogSxIZ+n04EMUZQ6ZFFx6FaBX5sgjUIp+
CDxkcbRLjNx4Bgj4Pe6Qo3VdtOcubkXh8mkWqbiYr7cQ+o6ZhQfxmTili+wBQGPG
84ylu0Kgvp5YG+1bAa5wew+mtf+szTucLar5a6dI2MMnB8yZkDO/Ku8y8Aj/cdmw
/AZWRtvrvhJyzjbx5JSnoHEeUFZNYDS6h8Uxf7q/nBjDrvwXQ67Ldh3zCc3jYPnL
8GQ/RC+e4ypxdxPf2FQmIpNqY4SHosoXxZ7zAPqqq5qUjP2Hry47a0etXrKp9bqa
86Hrwj75xLCkLTd/btf573nx23Vh0b4+n5p5ZwLh1QfjtETtbVApJR/FgVkJQEU7
d+3R63LoNDO0AO69WOJfyM7o2gIkr77faoh2dAoahMbZwwjG1r7UGmSxHxKMIrpW
/DxSFIsy4aulA+U8ekEg
=TpMx
-----END PGP SIGNATURE-----

--Nn26dT9qtJTf6VjBixu4iLbwGnd55SpBm--
