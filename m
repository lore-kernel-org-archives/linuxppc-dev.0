Return-Path: <sven.luther@wanadoo.fr>
Date: Wed, 1 Nov 2006 23:07:08 +0100
From: Sven Luther <sven@genesi-usa.com>
To: Dale Farnsworth <dale@farnsworth.org>
Subject: Re: [PATCH/RFC] powerpc: Add MPC5200 Interrupt Controller support.
Message-ID: <20061101220708.GA3328@powerlinux.fr>
References: <454902F9.20206@bplan-gmbh.de>
	<20061101220543.1541.qmail@farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061101220543.1541.qmail@farnsworth.org>
Cc: linuxppc-dev@ozlabs.org, sven@genesi-usa.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Nov 01, 2006 at 10:05:43PM -0000, Dale Farnsworth wrote:
> In article <454902F9.20206@bplan-gmbh.de> Nicolas wrote:
> > --- a/arch/powerpc/sysdev/mpc52xx_pic.c	1970-01-01 01:00:00.000000000 +0100
> > +++ b/arch/powerpc/sysdev/mpc52xx_pic.c	2006-11-01 21:16:40.000000000 +0100
> > @@ -0,0 +1,566 @@
> > +/*
> > + *
> > + * Programmable Interrupt Controller functions for the Freescale MPC52xx.
> > + * 
> > + * Copyright (C) 2006 bplan GmbH
> > + * 
> > + * This file is licensed under the terms of the GNU General Public License
> 
> Once again, please restore the copyright lines you removed from this file.

Hehe, you are aware that, IIRW, someone suggested to cut them earlier in this
thread ? 

Friendly,

Sven Luther
