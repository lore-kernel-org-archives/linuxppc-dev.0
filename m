Return-Path: <wimvs@spo001.leaseweb.com>
Received: from spo001.leaseweb.com (ns1.pc-advies.be [83.149.101.17])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 287841A0590
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 May 2014 07:35:07 +1000 (EST)
Date: Mon, 26 May 2014 23:05:40 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Yuantian.Tang@freescale.com
Subject: Re: [PATCH 1/1] booke/watchdog: refine and clean up the codes
Message-ID: <20140526210540.GA23641@spo001.leaseweb.com>
References: <1399514666-2572-1-git-send-email-Yuantian.Tang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1399514666-2572-1-git-send-email-Yuantian.Tang@freescale.com>
Sender: <wimvs@spo001.leaseweb.com>
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-watchdog@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Tang,

> From: Tang Yuantian <yuantian.tang@freescale.com>
> 
> Basically, this patch does the following:
> 1. Move the codes of parsing boot parameters from setup-common.c
>    to driver. In this way, code reader can know directly that
>    there are boot parameters that can change the timeout.
> 2. Make boot parameter 'booke_wdt_period' effective.
>    currently, when driver is loaded, default timeout is always
>    being used in stead of booke_wdt_period.
> 3. Wrap up the watchdog timeout in device struct and clean up
>    unnecessary codes.
> 
> Signed-off-by: Tang Yuantian <yuantian.tang@freescale.com>
> Acked-by: Scott Wood <scottwood@freescale.com>
> ---
> resend to watchdog maintainer
> 
>  arch/powerpc/kernel/setup-common.c | 27 --------------------
>  drivers/watchdog/booke_wdt.c       | 51 ++++++++++++++++++++++++--------------
>  2 files changed, 33 insertions(+), 45 deletions(-)

Patch has been added to linux-watchdog-next.

Kind regards,
Wim.
