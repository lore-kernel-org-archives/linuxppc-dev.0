Return-Path: <mkl@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D4A242C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Jun 2013 18:32:29 +1000 (EST)
Message-ID: <51A9B185.9030107@pengutronix.de>
Date: Sat, 01 Jun 2013 10:32:05 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2] can: flexcan: remove HAVE_CAN_FLEXCAN Kconfig symbol
References: <1368781157-4646-1-git-send-email-mkl@pengutronix.de>
 <20130517090949.GI8607@S2101-09.ap.freescale.net>
 <519A4A00.8000109@pengutronix.de> <1370043630.3928.166.camel@pasglop>
In-Reply-To: <1370043630.3928.166.camel@pasglop>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2NQWWNTOEEGEOGHGFBKJG"
Cc: Arnd Bergmann <arnd@arndb.de>, Sascha Hauer <s.hauer@pengutronix.de>,
 U Bhaskar-B22300 <B22300@freescale.com>, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2NQWWNTOEEGEOGHGFBKJG
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 06/01/2013 01:40 AM, Benjamin Herrenschmidt wrote:
> On Mon, 2013-05-20 at 18:06 +0200, Marc Kleine-Budde wrote:
>> On 05/17/2013 11:09 AM, Shawn Guo wrote:
>>> On Fri, May 17, 2013 at 10:59:17AM +0200, Marc Kleine-Budde wrote:
>>>> This patch removes the Kconfig symbol HAVE_CAN_FLEXCAN from arch/{ar=
m,powerpc}
>>>> and allowing compilation unconditionally on all arm and powerpc plat=
forms.
>>>>
>>>> This brings a bigger compile time coverage and removes the following=
 dependency
>>>> warning found by Arnd Bergmann:
>>>>
>>>>     warning: (SOC_IMX28 && SOC_IMX25 && SOC_IMX35 && IMX_HAVE_PLATFO=
RM_FLEXCAN &&
>>>>         SOC_IMX53 && SOC_IMX6Q) selects HAVE_CAN_FLEXCAN
>>>>     which has unmet direct dependencies (NET && CAN && CAN_DEV)
>>>>
>>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>>> Cc: Shawn Guo <shawn.guo@linaro.org>
>>>
>>> Acked-by: Shawn Guo <shawn.guo@linaro.org>
>>
>> Thanks.
>>
>> An Acked-by by the powerpc people would be fine. However, if nobody
>> doesn't object, I'm sending this patch via linux-can and net-next upst=
ream.
>=20
> Sorry, missed it, if it's still out there, add my
>=20
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Thanks,

Marc


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2NQWWNTOEEGEOGHGFBKJG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGpsYkACgkQjTAFq1RaXHNZjACfRw3YJ9tBYhgOf2denmTVtsfC
Ex4AoIUUJu5mxWre69cSk+SqByW5KXNE
=aWez
-----END PGP SIGNATURE-----

------enig2NQWWNTOEEGEOGHGFBKJG--
