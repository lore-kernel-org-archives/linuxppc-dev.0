Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BA898DDF91
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 09:28:22 +1000 (EST)
Date: Thu, 12 Apr 2007 18:24:26 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Dave Jiang <djiang@mvista.com>
Subject: Re: [PATCH] powerpc: fix comment in booke_wdt
In-Reply-To: <20070412203455.GA2008@blade.az.mvista.com>
Message-ID: <Pine.LNX.4.64.0704121823430.7202@localhost.localdomain>
References: <20070412203455.GA2008@blade.az.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 12 Apr 2007, Dave Jiang wrote:

> The early kernel parameter is wdt and not wdt_enable. according to
> arch/powerpc/kernel/setup_32.c:149.
>
> Signed-off-by: Dave Jiang <djiang@mvista.com>
>
> --
>
>  drivers/char/watchdog/booke_wdt.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> --
>

In the future, dont have a second '--' git-am looks for the last one.

Applied.

- k
