Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 23D66DE0CC
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 02:40:30 +1100 (EST)
Message-ID: <4798B14F.2020005@freescale.com>
Date: Thu, 24 Jan 2008 09:39:59 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] UCC TDM driver for QE based MPC83xx platforms.
References: <Pine.LNX.4.64.0801241014240.27491@linux121>
	<20080124171920.49d805cb.sfr@canb.auug.org.au>
In-Reply-To: <20080124171920.49d805cb.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Poonam_Aggrwal-b10812 <b10812@freescale.com>,
	michael.barkowski@freescale.com, netdev@vger.kernel.org,
	kumar.gala@freescale.com, linux-kernel@vger.kernel.org,
	rubini@vision.unipv.it, linuxppc-dev@ozlabs.org,
	ashish.kalra@freescale.com, rich.cutler@freescale.com,
	akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:

>> +	tdm_ctrl[device_num]->ut_info->uf_info.tdm_tx_clk =
>> +			(char *) of_get_property(np, "fsl,tdm-tx-clk", NULL);
>                                 ^
> We don't normall put spaces here.

Since when?

-- 
Timur Tabi
Linux kernel developer at Freescale
