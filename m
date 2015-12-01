Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 2A60C1A0B84
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Dec 2015 08:28:15 +1100 (AEDT)
Date: Tue, 01 Dec 2015 16:28:10 -0500 (EST)
Message-Id: <20151201.162810.1750455760429212300.davem@davemloft.net>
To: igal.liberman@freescale.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, scottwood@freescale.com,
 madalin.bucur@freescale.com, pebolle@tiscali.nl,
 joakim.tjernlund@transmode.se, ppc@mindchasers.com,
 stephen@networkplumber.org
Subject: Re: [v8, 2/6] fsl/fman: Add FMan support
From: David Miller <davem@davemloft.net>
In-Reply-To: <1448886062-16962-3-git-send-email-igal.liberman@freescale.com>
References: <1448886062-16962-1-git-send-email-igal.liberman@freescale.com>
 <1448886062-16962-3-git-send-email-igal.liberman@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: <igal.liberman@freescale.com>
Date: Mon, 30 Nov 2015 14:20:58 +0200

> +typedef irqreturn_t (fman_exceptions_cb)(struct fman *fman,
> +					 enum fman_exceptions exception);

Function and function pointer declarations and definitions should be
indented such that the second and subsequent lines begin precisely
at the first column after the openning parenthesis of the first line.

Please audit this and fix it in your entire submission, almost ever
new such case is done incorrectly.

> +	fman->state->exceptions = (EX_DMA_BUS_ERROR                 |
> +					EX_DMA_READ_ECC              |
> +					EX_DMA_SYSTEM_WRITE_ECC      |
> +					EX_DMA_FM_WRITE_ECC          |
> +					EX_FPM_STALL_ON_TASKS        |
> +					EX_FPM_SINGLE_ECC            |
> +					EX_FPM_DOUBLE_ECC            |
> +					EX_QMI_DEQ_FROM_UNKNOWN_PORTID |
> +					EX_BMI_LIST_RAM_ECC          |
> +					EX_BMI_STORAGE_PROFILE_ECC   |
> +					EX_BMI_STATISTICS_RAM_ECC    |
> +					EX_MURAM_ECC                 |
> +					EX_BMI_DISPATCH_RAM_ECC      |
> +					EX_QMI_DOUBLE_ECC            |
> +					EX_QMI_SINGLE_ECC);

The same applies to multi-line parenthesized expressions like this
one.  Again, please audit and fix this in your entire submission.

Thanks.
