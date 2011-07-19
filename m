Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7BFC0B6F70
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Jul 2011 00:20:10 +1000 (EST)
Subject: Re: [PATCH 00/14] Consolidation of 83xx/85xx board files
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1311065631-3429-1-git-send-email-dbaryshkov@gmail.com>
Date: Tue, 19 Jul 2011 09:20:03 -0500
Message-Id: <F4300901-1261-41DA-91E1-BE295B3C2BE7@kernel.crashing.org>
References: <1311065631-3429-1-git-send-email-dbaryshkov@gmail.com>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Linux PPC Development <linuxppc-dev@lists.ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 19, 2011, at 3:53 AM, Dmitry Eremin-Solenikov wrote:

> I think it's already too late for this merge window, so this should =
stay
> for 3.2 merge window. Board files for mpc83xx platforms show lots of =
common
> code. Same goes for mpc85xx boards. This patchset is an initial =
attempt
> to merge some (most) of the common code. Based on the tree by Kumar =
Gala.
>=20
> The following changes since commit =
6471fc6630a507fd54fdaceceee1ddaf3c917cde:
>=20
>  powerpc: Dont require a dma_ops struct to set dma mask (2011-07-08 =
00:21:36 -0500)
>=20
> Dmitry Eremin-Solenikov (14):
>      83xx: consolidate init_IRQ functions
>      83xx: consolidate of_platform_bus_probe calls
>      mpc8349emitx: mark localbus as compatible with simple-bus
>      83xx/mpc834x_itx: drop pq2pro-localbus-specific code
>      83xx: headers cleanup
>      85xx/sbc8560: correct compilation if CONFIG_PHYS_ADDR_T_64BIT is =
set
>      85xx/ksi8560: declare that localbus is compatbile with simple-bus
>      85xx/sbc8560: declare that localbus is compatbile with simple-bus
>      85xx/sbc8548: read hardware revision when it's required for first =
time
>      85xx/mpc85xx_rdb: merge p1020_rdb and p2020_rdb machine entries
>      85xx: merge 32-bit QorIQ with DPA boards support
>      85xx/mpc85xx_ds,ads,cds: move .pci_exclude_device setting to =
machine definitions
>      85xx: consolidate of_platform_bus_probe calls
>      85xx: separate cpm2 pic init

Also patches subject should be of the form:

powerpc/85xx: ....

Please fix on next patch posting.

- k=
