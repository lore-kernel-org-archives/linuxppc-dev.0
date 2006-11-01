Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id 127CF67C2F
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Nov 2006 09:12:25 +1100 (EST)
Date: 1 Nov 2006 22:05:43 -0000
Message-ID: <20061101220543.1541.qmail@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
To: nd@bplan-gmbh.de, linuxppc-embedded@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH/RFC] powerpc: Add MPC5200 Interrupt Controller support.
In-Reply-To: <454902F9.20206@bplan-gmbh.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In article <454902F9.20206@bplan-gmbh.de> Nicolas wrote:
> --- a/arch/powerpc/sysdev/mpc52xx_pic.c	1970-01-01 01:00:00.000000000 +0100
> +++ b/arch/powerpc/sysdev/mpc52xx_pic.c	2006-11-01 21:16:40.000000000 +0100
> @@ -0,0 +1,566 @@
> +/*
> + *
> + * Programmable Interrupt Controller functions for the Freescale MPC52xx.
> + * 
> + * Copyright (C) 2006 bplan GmbH
> + * 
> + * This file is licensed under the terms of the GNU General Public License

Once again, please restore the copyright lines you removed from this file.

Dale Farnsworth
