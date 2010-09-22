Return-Path: <R1AAHA@freescale.com>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) by ozlabs.org (Postfix) with ESMTP id 42A42B70DF
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Sep 2010 09:26:23 +1000 (EST)
Received: from mail129-tx2 (localhost.localdomain [127.0.0.1])	by
	mail129-tx2-R.bigfish.com (Postfix) with ESMTP id 8592213984B4	for
	<linuxppc-dev@ozlabs.org>; Wed, 22 Sep 2010 23:26:19 +0000 (UTC)
Received: from TX2EHSMHS013.bigfish.com (unknown [10.9.14.241])	by
	mail129-tx2.bigfish.com (Postfix) with ESMTP id 6B789CC0050	for
	<linuxppc-dev@ozlabs.org>; Wed, 22 Sep 2010 23:26:19 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o8MNQHc9024505	for <linuxppc-dev@ozlabs.org>;
	Wed, 22 Sep 2010 16:26:18 -0700 (MST)
Received: from az33exm22.fsl.freescale.net (az33exm22.am.freescale.net
	[10.64.32.10])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
	o8MNQNCd017575	for <linuxppc-dev@ozlabs.org>;
	Wed, 22 Sep 2010 18:26:23 -0500 (CDT)
Date: Wed, 22 Sep 2010 18:26:16 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: m.johansen@no.parkairsystems.com
Subject: Re: Modifying mpc8308rdb.dts
Message-ID: <20100922182616.a0c4d460.kim.phillips@freescale.com>
In-Reply-To: <DF61B4AD1C20A54EADF5C05E1F1110DE08D43B@Exchange.parkairsystems.net>
References: <DF61B4AD1C20A54EADF5C05E1F1110DE08D43B@Exchange.parkairsystems.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 22 Sep 2010 12:32:20 +0200
Maria Johansen <m.johansen@no.parkairsystems.com> wrote:

> I am working on an MPC8308rdb, and have needed to add support for spi
> and an lm75 thermal sensor on the i2c-bus. Is it possible to upload my
> changes to the "official" mpc8308rdb.dts, or should I just keep
> modifying it locally and hope the maintainers of the file will add
> support for more devices soon?

posting patches beats waiting for an indefinite amount of time :)

Kim
