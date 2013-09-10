Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 863902C0102
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2013 08:31:20 +1000 (EST)
Message-ID: <1378852272.12204.366.camel@snotra.buserror.net>
Subject: Re: [PATCH 7/7] powerpc/b4860emu: Add device tree file for b4860emu
From: Scott Wood <scottwood@freescale.com>
To: York Sun <yorksun@freescale.com>
Date: Tue, 10 Sep 2013 17:31:12 -0500
In-Reply-To: <1378482199-10581-7-git-send-email-yorksun@freescale.com>
References: <1378482199-10581-1-git-send-email-yorksun@freescale.com>
 <1378482199-10581-7-git-send-email-yorksun@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-09-06 at 08:43 -0700, York Sun wrote:
> B4860EMU is a emualtor target with minimum peripherals. It is based on
> B4860QDS and trimmed down most peripherals due to either not modeled or
> lack of board level connections. The main purpose of this minimum dts is
> to speed up booting on emulator.
> 
> Signed-off-by: York Sun <yorksun@freescale.com>
> Reviewed-by: Wood Scott-B07421 <scottwood@freescale.com>
> Reviewed-by: Fleming Andrew-AFLEMING <AFLEMING@freescale.com>
> Tested-by: Fleming Andrew-AFLEMING <AFLEMING@freescale.com>

I did not give a reviewed-by in this context.  Please strip gerrit tags
before posting.

> +	clockgen: global-utilities@e1000 {
> +		compatible = "fsl,b4860-clockgen", "fsl,qoriq-clockgen-2";

It's "fsl,qoriq-clockgen-2.0" now.

Please be careful with copy-and-paste patches like this -- make sure
that it's up-to-date with what you copied from.

-Scott
