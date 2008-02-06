Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1FDC8DDF60
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Feb 2008 16:37:47 +1100 (EST)
Message-Id: <83451BF1-8ECC-4D89-8C0E-1E51E0BC613B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080131173656.GA10385@loki.buserror.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] adder875, ep88xc: fix to match recent 8xx cleanups.
Date: Tue, 5 Feb 2008 23:37:35 -0600
References: <20080131173656.GA10385@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 31, 2008, at 11:36 AM, Scott Wood wrote:

> asm/commproc.h was renamed to asm/cpm1.h
> sysdev/commproc.h was renamed to platforms/8xx/mpc8xx.h
> m8xx_pic_init was renamed to mpc8xx_pics_init
>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> arch/powerpc/platforms/8xx/adder875.c |    6 +++---
> arch/powerpc/platforms/8xx/ep88xc.c   |    1 -
> 2 files changed, 3 insertions(+), 4 deletions(-)


applied.

- k
