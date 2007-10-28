Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 4EC38DDDCA
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Oct 2007 12:38:59 +1100 (EST)
Date: Sun, 28 Oct 2007 12:38:50 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2] [POWERPC] Fix CONFIG_SMP=n build break
Message-Id: <20071028123850.e5b9c555.sfr@canb.auug.org.au>
In-Reply-To: <20071027172851.GA11930@lixom.net>
References: <20071026165510.GA2323@lixom.net>
	<200710262019.12094.arnd@arndb.de>
	<20071027172851.GA11930@lixom.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sun__28_Oct_2007_12_38_50_+1100_AOw9H7o_ifcB932+"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sun__28_Oct_2007_12_38_50_+1100_AOw9H7o_ifcB932+
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Olof,

Just a trivial thing ...

On Sat, 27 Oct 2007 12:28:51 -0500 Olof Johansson <olof@lixom.net> wrote:
>
> +u8 iic_get_target_id(int cpu)
> +{
> +	return per_cpu(iic, cpu).target_id;
> +}
> +
> +EXPORT_SYMBOL_GPL(iic_get_target_id);

We don't normally put a blank line between a function and its EXPORT...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__28_Oct_2007_12_38_50_+1100_AOw9H7o_ifcB932+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD4DBQFHI+gvTgG2atn1QN8RAtViAJMEfDSk9tA6UiVQfyDo3xPKB9C6AJ9rsw63
mcc5TbsvOgB7NjlfXCgvJg==
=+olZ
-----END PGP SIGNATURE-----

--Signature=_Sun__28_Oct_2007_12_38_50_+1100_AOw9H7o_ifcB932+--
