Return-Path: <khali@linux-fr.org>
Received: from kellthuzad.dmz.nerim.net (smtp-dmz-231-monday.dmz.nerim.net
	[195.5.254.231]) by ozlabs.org (Postfix) with ESMTP id 85255DDFAA
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 06:19:58 +1000 (EST)
Received: from mallaury.nerim.net (smtp-101-monday.noc.nerim.net [62.4.17.101])
	by kellthuzad.dmz.nerim.net (Postfix) with ESMTP id C65EB2699B
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 22:19:45 +0200 (CEST)
Date: Mon, 15 Oct 2007 22:19:49 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 1/2] i2c: ibm_iic: Whitespace cleanup
Message-ID: <20071015221949.0db47419@hyperion.delvare>
In-Reply-To: <200710151528.55261.sr@denx.de>
References: <200710151528.55261.sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Stefan,

On Mon, 15 Oct 2007 15:28:54 +0200, Stefan Roese wrote:
> Signed-off-by: Stefan Roese <sr@denx.de>
> ---
>  drivers/i2c/busses/i2c-ibm_iic.c |  192 +++++++++++++++++++-------------=
------
>  drivers/i2c/busses/i2c-ibm_iic.h |    8 +-
>  2 files changed, 100 insertions(+), 100 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ib=
m_iic.c
> index e08baca..956b947 100644
> --- a/drivers/i2c/busses/i2c-ibm_iic.c
> +++ b/drivers/i2c/busses/i2c-ibm_iic.c
> @@ -6,7 +6,7 @@
>   * Copyright (c) 2003, 2004 Zultys Technologies.
>   * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
>   *
> - * Based on original work by=20
> + * Based on original work by
>   * 	Ian DaSilva  <idasilva@mvista.com>
>   *      Armin Kuster <akuster@mvista.com>
>   * 	Matt Porter  <mporter@mvista.com>
> @@ -18,7 +18,7 @@
>   *   	Copyright 1995-97 Simon G. Vogl
>   *                1998-99 Hans Berglund
>   *
> - *   	With some changes from Ky=F6sti M=E4lkki <kmalkki@cc.hut.fi>=20
> + *   	With some changes from Ky=F6sti M=E4lkki <kmalkki@cc.hut.fi>
>   *	and even Frodo Looijaard <frodol@dds.nl>
>   *
>   * This program is free software; you can redistribute  it and/or modify=
 it

(etc.)

Applied, thank you.

--=20
Jean Delvare
