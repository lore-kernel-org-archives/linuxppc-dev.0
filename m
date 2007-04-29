Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id B458CDDF14
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Apr 2007 16:54:53 +1000 (EST)
Date: Sun, 29 Apr 2007 01:55:33 -0500
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] [POWERPC] get_property cleanups
Message-ID: <20070429065533.GA8241@lixom.net>
References: <20070429162908.c8bffbec.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070429162908.c8bffbec.sfr@canb.auug.org.au>
From: olof@lixom.net (Olof Johansson)
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Apr 29, 2007 at 04:29:08PM +1000, Stephen Rothwell wrote:
> Just another pass through arch/powerpc for old usages.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/powerpc/platforms/cell/ras.c         |    4 ++--
>  arch/powerpc/platforms/pasemi/cpufreq.c   |   11 ++++++-----
>  arch/powerpc/platforms/pasemi/gpio_mdio.c |    6 +++---
>  arch/powerpc/sysdev/uic.c                 |    8 ++++----

arch/powerpc/platforms/cell/cbe-cpufreq.c needs the same changes as paseemi/cpufreq.c.

-Olof
