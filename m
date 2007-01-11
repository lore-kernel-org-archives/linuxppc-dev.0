Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4A978DDF93
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 08:37:23 +1100 (EST)
Subject: Re: [PATCH 2/2] drivers/ata: export some static functions in
	libata-core.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
In-Reply-To: <200701110928.l0B9SUUv028654@toshiba.co.jp>
References: <200701110853.l0B8rtGK009404@toshiba.co.jp>
	<200701111008.34866.arnd@arndb.de>
	<200701110928.l0B9SUUv028654@toshiba.co.jp>
Content-Type: text/plain
Date: Fri, 12 Jan 2007 08:37:12 +1100
Message-Id: <1168551432.22458.421.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-ide@vger.kernel.org, paulus@samba.org, Arnd Bergmann <arnd@arndb.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-01-11 at 18:30 +0900, Akira Iguchi wrote:
> Hi, Arnd-san.
> 
> Thank you for checking our patches.
> 
> >On Thursday 11 January 2007 09:56, Akira Iguchi wrote:
> >> This patch modifies some static functions in libata-core.c
> >> and libata.h to use them in ata_scc.c.
> >
> >Exporting new symbols needs some explanation here about why they
> >should now be global for ata_scc while the existing drivers
> >did not need them. Since the patch otherwise only moves stuff
> >around as needed, I assume it's good.
> 
> I thought it was better to use common functions as far as possible.
> But if it is preferable to copy them in ata_scc.c, I will do so.

Nah, it's not preferable. I think what is preferable on the contrary is
to make even more common function generic enough so you can use them
instead of copying them.

Ben.
