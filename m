Return-Path: <stephen@networkplumber.org>
Received: from mail-pa0-f50.google.com (mail-pa0-f50.google.com
 [209.85.220.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 064881A1A49
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 02:55:49 +1000 (AEST)
Received: by pabkd10 with SMTP id kd10so69242230pab.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 09:55:47 -0700 (PDT)
Date: Wed, 22 Jul 2015 09:55:53 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: <igal.liberman@freescale.com>
Cc: <netdev@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, <scottwood@freescale.com>,
 <madalin.bucur@freescale.com>, <pebolle@tiscali.nl>,
 <joakim.tjernlund@transmode.se>, <ppc@mindchasers.com>
Subject: Re: [v3, 2/9] fsl/fman: Add the FMan port FLIB
Message-ID: <20150722095553.4cd028d1@urahara>
In-Reply-To: <1437564108-16490-1-git-send-email-igal.liberman@freescale.com>
References: <1437564108-16490-1-git-send-email-igal.liberman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 22 Jul 2015 14:21:48 +0300
<igal.liberman@freescale.com> wrote:

> diff --git a/drivers/net/ethernet/freescale/fman/Kconfig b/drivers/net/ethernet/freescale/fman/Kconfig
> index 8aeae29..af42c3a 100644
> --- a/drivers/net/ethernet/freescale/fman/Kconfig
> +++ b/drivers/net/ethernet/freescale/fman/Kconfig
> @@ -5,3 +5,4 @@ config FSL_FMAN
>  	help
>  		Freescale Data-Path Acceleration Architecture Frame Manager
>  		(FMan) support
> +

Bogus blank line introduced at end of file?
Why was this not in patch 1?
