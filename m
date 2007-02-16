Return-Path: <paul.gortmaker@windriver.com>
Received: from yow-pgortmak-d1.corp.ad.wrs.com (unknown [67.71.254.34])
	by ozlabs.org (Postfix) with ESMTP id CE183DDE20
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 02:13:35 +1100 (EST)
Date: Fri, 16 Feb 2007 10:14:11 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: Re: [PATCH] Fix compile failure in cpm_uart_cpm2
Message-ID: <20070216151410.GA5682@windriver.com>
References: <20070215174305.GA2820@windriver.com>
	<20070215233139.5b9eab08@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070215233139.5b9eab08@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, p_gortmaker@yahoo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message: Re: [PATCH] Fix compile failure in cpm_uart_cpm2
on 15/02/2007 Vitaly Bordug wrote:

> On Thu, 15 Feb 2007 12:43:06 -0500
> Paul Gortmaker wrote:
> 
> > Fix bug that exists in kernel.org since 2.6.17rc4 - compiles fail if
> > CONFIG_SERIAL_CPM_SMC is defined.  Tested on a board using SMC1
> > console.
> > 
> 
> This has been submitted already by Heiko Schocher <hs@denx.de>, sorry... 
> Anyway, got to be fixed soon.

Hi Vitaly,

Thanks for the reference; I'd not seen Heiko's patch.  I see it is in git
already this morning as well.

Paul.
