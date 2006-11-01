Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id 20CDD67C94
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Nov 2006 09:21:47 +1100 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Wed, 1 Nov 2006 15:21:46 -0700
To: Sven Luther <sven@genesi-usa.com>
Subject: Re: [PATCH/RFC] powerpc: Add MPC5200 Interrupt Controller support.
Message-ID: <20061101222146.GA3935@xyzzy.farnsworth.org>
References: <454902F9.20206@bplan-gmbh.de>
	<20061101220543.1541.qmail@farnsworth.org>
	<20061101220708.GA3328@powerlinux.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061101220708.GA3328@powerlinux.fr>
Cc: linuxppc-embedded@ozlabs.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Nov 01, 2006 at 11:07:08PM +0100, Sven Luther wrote:
> On Wed, Nov 01, 2006 at 10:05:43PM -0000, Dale Farnsworth wrote:
> > In article <454902F9.20206@bplan-gmbh.de> Nicolas wrote:
> > > --- a/arch/powerpc/sysdev/mpc52xx_pic.c	1970-01-01 01:00:00.000000000 +0100
> > > +++ b/arch/powerpc/sysdev/mpc52xx_pic.c	2006-11-01 21:16:40.000000000 +0100
> > > @@ -0,0 +1,566 @@
> > > +/*
> > > + *
> > > + * Programmable Interrupt Controller functions for the Freescale MPC52xx.
> > > + * 
> > > + * Copyright (C) 2006 bplan GmbH
> > > + * 
> > > + * This file is licensed under the terms of the GNU General Public License
> > 
> > Once again, please restore the copyright lines you removed from this file.
> 
> Hehe, you are aware that, IIRW, someone suggested to cut them earlier in this
> thread ? 

I think people called for removing the "Maintained by" and the
changelog-like commentary, but not the copyrights.

-Dale
