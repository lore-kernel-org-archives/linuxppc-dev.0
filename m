Return-Path: <adrian@humboldt.co.uk>
Received: from mail.humboldt.co.uk (mail.humboldt.co.uk [80.68.93.146])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D505067B9B
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Aug 2006 05:36:44 +1000 (EST)
Subject: Re: SMP in 32-bit arch/powerpc
From: Adrian Cox <adrian@humboldt.co.uk>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <027C3DD1-67E1-4CF2-B8B6-36CD1F09D1D2@kernel.crashing.org>
References: <1154507145.24203.0.camel@localhost.localdomain>
	<027C3DD1-67E1-4CF2-B8B6-36CD1F09D1D2@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 02 Aug 2006 20:36:34 +0100
Message-Id: <1154547394.5413.1.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-08-02 at 08:32 -0500, Kumar Gala wrote:
> On Aug 2, 2006, at 3:25 AM, Adrian Cox wrote:
> > Is anybody else having problems with 32-bit SMP support in arch/ 
> > powerpc?
> > I'm using 2.6.17 as my current base, because I've not yet merged the
> > latest mpic changes.

> There are a few patches to prom.c that may help.  I know I've run  
> into this on other 32-bit systems booting from u-boot.  These patches  
> resolved my issue.
> * [PATCH] powerpc: Auto reserve of device tree blob
> * [POWERPC] Prevent duplicate lmb reservations for Device...

That was the problem. It now boots correctly, thanks.

-- 
Adrian Cox <adrian@humboldt.co.uk>
