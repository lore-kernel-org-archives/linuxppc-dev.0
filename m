Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 624D5DDD0E
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Mar 2007 17:53:29 +1100 (EST)
Subject: Re: [POWERPC] Clean up deciding when PCI is selectable
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20070307164737.e927711d.sfr@canb.auug.org.au>
References: <20070304165839.4d2bf50b.sfr@canb.auug.org.au>
	<20070304170348.511af7cb.sfr@canb.auug.org.au>
	<20070304170444.2eb423ce.sfr@canb.auug.org.au>
	<200703041507.06307.arnd@arndb.de>
	<1173033826.8184.68.camel@localhost.localdomain>
	<20070307164737.e927711d.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Wed, 07 Mar 2007 07:53:11 +0100
Message-Id: <1173250391.9349.21.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-03-07 at 16:47 +1100, Stephen Rothwell wrote:
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/powerpc/Kconfig                       |   18 +++++++++++++++---
>  arch/powerpc/platforms/85xx/Kconfig        |    1 +
>  arch/powerpc/platforms/embedded6xx/Kconfig |    2 ++
>  3 files changed, 18 insertions(+), 3 deletions(-)
> 
> On Sun, 04 Mar 2007 19:43:46 +0100 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> > I dislike the giant conditional though.
> 
> How about this (only tested on a couple of configs).

I much prefer this one yes.
