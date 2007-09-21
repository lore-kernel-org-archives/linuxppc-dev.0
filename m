Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EAB81DDEDA
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 10:44:22 +1000 (EST)
Date: Thu, 20 Sep 2007 19:44:06 -0500
From: Scott Wood <scottwood@freescale.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 6/9] fs_enet: Be an of_platform device when
	CONFIG_PPC_CPM_NEW_BINDING is set.
Message-ID: <20070921004406.GA19279@ld0162-tx32.am.freescale.net>
References: <20070920220043.GA28769@loki.buserror.net>
	<20070920220121.GF28784@loki.buserror.net>
	<20070921100841.6904f2bc.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070921100841.6904f2bc.sfr@canb.auug.org.au>
Cc: netdev@vger.kernel.org, jgarzik@pobox.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 21, 2007 at 10:08:41AM +1000, Stephen Rothwell wrote:
> On Thu, 20 Sep 2007 17:01:21 -0500 Scott Wood <scottwood@freescale.com> wrote:
> >
> > +++ b/drivers/net/fs_enet/fs_enet-main.c
> > @@ -44,12 +44,18 @@
> >  #include <asm/irq.h>
> >  #include <asm/uaccess.h>
> >  
> > +#ifdef CONFIG_PPC_CPM_NEW_BINDING
> > +#include <asm/of_platform.h>
> 
> Hmm, didn't I already ask you to change this to linux/of_platform.h?

Grrr, I thought I'd gotten them all.
 
-Scott
