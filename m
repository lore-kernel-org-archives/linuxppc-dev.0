Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (67-40-242-100.roch.qwest.net
	[67.40.242.100])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2A53F67B92
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Sep 2006 11:11:54 +1000 (EST)
Subject: Re: [PATCH] [v3] PPC 4xx: Enable XMON on PPC 4xx boards
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1157677403.22705.360.camel@localhost.localdomain>
References: <1157639720.6098.49.camel@zod.rchland.ibm.com>
	<20060907171916.GB18929@gate.ebshome.net>
	<1157652525.6098.61.camel@zod.rchland.ibm.com>
	<1157677403.22705.360.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 07 Sep 2006 20:10:54 -0500
Message-Id: <1157677854.2721.39.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, mporter@embeddedalley.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-09-08 at 11:03 +1000, Benjamin Herrenschmidt wrote:
> > Blindly following the existing convention.  I agree it's ugly.  I'll fix
> > it up shortly and send out another patch.  It'll also fix 440SPE, which
> > also has a different UART address.
> 
> It should all move to udbg anyway

udbg is arch/powerpc.  This is arch/ppc.  I have every intention of
porting this to arch/powerpc when 4xx itself moves over and I'll gladly
use udbg then.

Until then, I'd still like to get this patch (v4) into the kernel since
it's quite useful now.

josh
