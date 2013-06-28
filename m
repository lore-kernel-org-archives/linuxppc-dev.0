Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2B7DA2C009D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Jun 2013 08:15:56 +1000 (EST)
Date: Fri, 28 Jun 2013 17:15:46 -0500
From: Scott Wood <scottwood@freescale.com>
To: Sandeep Singh <sandeep@freescale.com>
Subject: Re: [1/4] Device tree entry for Freescale TDM controller
Message-ID: <20130628221545.GA9357@home.buserror.net>
References: <1362655668-26721-1-git-send-email-Sandeep@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1362655668-26721-1-git-send-email-Sandeep@freescale.com>
Cc: Poonam Aggrwal <poonam.aggrwal@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 07, 2013 at 04:57:45PM +0530, Sandeep Singh wrote:
> +tdm@16000 {
> +	compatible = "fsl,tdm1.0";
> +	reg = <0x16000 0x200 0x2c000 0x2000>;
> +	clock-frequency = <0>;
> +	tdm_tx_clk = <2048000>;
> +	interrupts = <62 8 0 0>;
> +	fsl,max-time-slots = <128>;
> +};

tdm_tx_clk isn't in the binding (and should be named fsl,tdm-tx-clk if it
is meant to be here at all).

-Scott
