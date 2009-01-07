Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4212ADE547
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 13:46:45 +1100 (EST)
Subject: Re: [PATCH] ppc64: Enable RELOCATABLE option for CRASH_DUMP
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <0ba5eb018563b895658033d2db0c9b9f@bga.com>
References: <0ba5eb018563b895658033d2db0c9b9f@bga.com>
Content-Type: text/plain
Date: Wed, 07 Jan 2009 13:45:45 +1100
Message-Id: <1231296345.14860.49.camel@pasglop>
Mime-Version: 1.0
Cc: linux-ppc <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2009-01-05 at 07:28 -0600, Milton Miller wrote:
> Mohan wrote:
> 
> >  config CRASH_DUMP
> >         bool "Build a kdump crash kernel"
> > -       depends on (PPC64 && RELOCATABLE) || 6xx
> > +       depends on PPC64 || 6xx
> > +       select RELOCATABLE
> >         help
> >           Build a kernel suitable for use as a kdump capture kernel.
> >           The same kernel binary can be used as production kernel and 
> > dump
> >
> 
> You should only select relocatable if ppc64

Please, can you try to conserve the mail IDs when you reply ? Not only
you break threads, but your replies never make it to patchwork which
makes it hard for me to know that you commented or acked/nacked a patch.

Thanks !

Cheers,
Ben.
