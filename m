Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 85FEADDED5
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 01:31:17 +1100 (EST)
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH 2/3] Convert PowerPC MPC i2c to of_platform_driver from
	platform_driver
In-Reply-To: Your message of "Tue, 22 Jan 2008 21:09:14 EST."
	<20080123020914.31675.35659.stgit@terra.home>
References: <20080123020912.31675.48787.stgit@terra.home>
	<20080123020914.31675.35659.stgit@terra.home>
Date: Wed, 23 Jan 2008 08:31:09 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1JHgdB-0002zV-F4@jdl.com>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Jon Smirl mumbled:
> Convert MPC i2c driver from a platform_driver to a
> of_platform_driver. Add the ability to dynamically load i2c drivers
> based on device tree names. Routine names were changed from fsl_ to
> mpc_ to make them match the file name. Common code moved to
> powerpc-common.* Orginal ppc driver left intact for deletion when ppc
> arch is removed.

This seems backwards to me.  I was under the impression
that our trend was _toward_ "Freescale" and "fsl" names...?
And aren't the drivers also already using "fsl-i2c" in the
DTS files as called out in the b-w-o.txt too?

Grumble long lines not hard-limited to 70-ish columns,
yes, even in log messages... :-)

jdl
