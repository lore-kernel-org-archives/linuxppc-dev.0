Return-Path: <kim.phillips@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3171DDDE22
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 06:24:41 +1000 (EST)
Date: Tue, 22 May 2007 15:24:27 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: will_schmidt@vnet.ibm.com
Subject: Re: [PATCH] powerpc: Fix powerpc vmlinux.lds.S
Message-Id: <20070522152427.24055847.kim.phillips@freescale.com>
In-Reply-To: <1179846105.16032.75.camel@farscape.rchland.ibm.com>
References: <1179808385.32247.791.camel@localhost.localdomain>
	<1179846105.16032.75.camel@farscape.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 22 May 2007 10:01:44 -0500
Will Schmidt <will_schmidt@vnet.ibm.com> wrote:

> On Tue, 2007-22-05 at 14:33 +1000, Benjamin Herrenschmidt wrote:
> > Sam's recent changes broke things for us, some stuff sneaked in before
> > the entry point. In fact, we don't need that *(.text.*) thing anymore
> > and it incorrectly matched .text.init.refok, thus putting it
> > before .text. .. ouch !
> 
> ..  Which manifests itself on some systems as a hang after 
> "returning from prom_init".  
> 
> 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Applying this makes my systems happy again... :-)
> 
same here.

> Acked-by:  Will Schmidt <will_schmidt@vnet.ibm.com>
> 
Acked-by:  Kim Phillips <kim.phillips@freescale.com>

Kim
