Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 57BB5DDFC3
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jun 2007 13:18:05 +1000 (EST)
Date: Wed, 6 Jun 2007 13:17:55 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [patch 11/18] PS3: System-bus modinfo attribute
Message-Id: <20070606131755.7b815d22.sfr@canb.auug.org.au>
In-Reply-To: <4666235C.10209@am.sony.com>
References: <20070606024407.786638029@am.sony.com> <4666235C.10209@am.sony.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__6_Jun_2007_13_17_55_+1000_AZYTpcyweU0CRnEc"
Cc: linuxppc-dev@ozlabs.org, Paul, David Woodhouse <dwmw2@infradead.org>,
	Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__6_Jun_2007_13_17_55_+1000_AZYTpcyweU0CRnEc
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 05 Jun 2007 20:00:44 -0700 Geoff Levand <geoffrey.levand@am.sony.co=
m> wrote:
>
> +static ssize_t modalias_show(struct device *_dev, struct device_attribut=
e *a,
> +			     char *buf)
> +{
> +	struct ps3_system_bus_device *dev =3D ps3_dev_to_system_bus_dev(_dev);
> +        int len =3D snprintf(buf, PAGE_SIZE, "ps3:%d\n", dev->match_id);

Broken whitespace ...

> +
> +        return (len >=3D PAGE_SIZE) ? (PAGE_SIZE - 1) : len;

And here.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__6_Jun_2007_13_17_55_+1000_AZYTpcyweU0CRnEc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGZidsFdBgD/zoJvwRAhXIAJ0YqM8iaiPxqHZAlH8chlHZwI2QVACfX0PX
u5qxjJ3UAZj70WBv/xdZUTA=
=CNiC
-----END PGP SIGNATURE-----

--Signature=_Wed__6_Jun_2007_13_17_55_+1000_AZYTpcyweU0CRnEc--
