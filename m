Return-Path: <R58495@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4A67C2C00F8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Sep 2013 09:41:40 +1000 (EST)
Message-ID: <52379704.4010500@freescale.com>
Date: Mon, 16 Sep 2013 16:40:52 -0700
From: York Sun <yorksun@freescale.com>
MIME-Version: 1.0
To: <galak@kernel.crashing.org>
Subject: Re: [linuxppc-release] [Patch v2 1/2] powerpc/t4240emu: Add device
 tree file for t4240emu
References: <1379374687-13922-1-git-send-email-yorksun@freescale.com>
In-Reply-To: <1379374687-13922-1-git-send-email-yorksun@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/16/2013 04:38 PM, York Sun wrote:
> T4240EMU is an emulator target with minimum peripherals. It is based on
> T4240QDS and trimmed down most peripherals due to either not modeled or
> lack of board level connections. The main purpose of this minimum dts is
> to speed up booting on emulator.
> 
> Signed-off-by: York Sun <yorksun@freescale.com>
> ---
> Change log:
>  v2: remote reviewed-by and tested-by lines added by gerrit
>      resync with t4240qds.dts
> 

Pardon my typo. I meant to type "remove", instead of "remote".

York
