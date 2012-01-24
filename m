Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6A0BAB6F65
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2012 10:08:31 +1100 (EST)
Subject: Re: [PATCH] powerpc/85xx: fix Kconfig warning about missing 8250
 dependency
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1327022600-24206-1-git-send-email-paul.gortmaker@windriver.com>
Date: Tue, 24 Jan 2012 17:08:24 -0600
Message-Id: <D5B3B1A1-2D30-470E-B6EF-9F7A64228DEF@kernel.crashing.org>
References: <1327022600-24206-1-git-send-email-paul.gortmaker@windriver.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 19, 2012, at 7:23 PM, Paul Gortmaker wrote:

> The SERIAL_8250_EXTENDED option just enables access to other
> less regularly used options, like SERIAL_8250_SHARE_IRQ.
> Select it to get rid of this warning when selecting the child
> option living underneath it.
> 
>  warning: (FSL_SOC_BOOKE && SERIAL_8250_RM9K) selects
>  SERIAL_8250_SHARE_IRQ which has unmet direct dependencies
>  (HAS_IOMEM && SERIAL_8250_EXTENDED)
> 
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

applied to merge

- k
