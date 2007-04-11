Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EDAFBDDF0D
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 00:16:43 +1000 (EST)
Date: Wed, 11 Apr 2007 09:16:33 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Benjamin Zores <benjamin.zores@alcatel-lucent.fr>
Subject: Re: Strange behavior when booting MPC8349E-mITX card.
Message-Id: <20070411091633.7f12d86e.kim.phillips@freescale.com>
In-Reply-To: <20070411110935.1161908f.benjamin.zores@alcatel-lucent.fr>
References: <20070411110935.1161908f.benjamin.zores@alcatel-lucent.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 11 Apr 2007 11:09:35 +0200
Benjamin Zores <benjamin.zores@alcatel-lucent.fr> wrote:

> Hi,
> 
> I've noticed a strange behavior when booting an MPC8349E-mITX card
> in PowerPC architecture (not ppc) on Linux 2.6.19.2.
> 
> It seems like early parts of the kernel featuring platform configuration are executed twice ? I don't know if it's intended or not but at least the card
> works pretty well. I boots completely and there's no problem with that.
> I just want to understand why it does such a thing.
> 
> I'm running a vanilla 2.6.19.2 kernel, ARCH=powerpc make mpc834x_itx_defconfig
> and the vanilla DTS file for this card.
> 
> I don't have other platform to test this behavior.
> Does anyone else noticed the same thing ?
> 
see:

http://ozlabs.org/pipermail/linuxppc-dev/2007-January/030734.html

Kim
