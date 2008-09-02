Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 82606DDDDF
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Sep 2008 04:27:32 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m82IRB0t002537
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Sep 2008 11:27:11 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m82IRAOw011927
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Sep 2008 13:27:10 -0500 (CDT)
Date: Tue, 2 Sep 2008 13:27:09 -0500
From: Scott Wood <scottwood@freescale.com>
To: Martyn Welch <martyn.welch@gefanuc.com>
Subject: Re: [PATCH v4 1/2] powerpc: Board support for GE Fanuc SBC610
Message-ID: <20080902182709.GB16741@ld0162-tx32.am.freescale.net>
References: <20080901102753.8068.36706.stgit@ubuntu8041.localdomain>
	<20080901102758.8068.77414.stgit@ubuntu8041.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080901102758.8068.77414.stgit@ubuntu8041.localdomain>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 01, 2008 at 11:27:59AM +0100, Martyn Welch wrote:
> +static __initdata struct of_device_id of_bus_ids[] = {
> +	{ .compatible = "simple-bus", },
> +	{ .type = "serial", },
> +	{ .type = "soc", },
> +	{ .type = "i2c", },

i2c and serial don't belong here, and soc is redundant with simple-bus.

-Scott
