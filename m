Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0188.outbound.protection.outlook.com [207.46.163.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 24AE714012A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Apr 2014 08:47:34 +1100 (EST)
Message-ID: <1396388833.32034.18.camel@snotra.buserror.net>
Subject: Re: [PATCH 2/3] powerpc/fsl-booke: Add initial T208x QDS board support
From: Scott Wood <scottwood@freescale.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Date: Tue, 1 Apr 2014 16:47:13 -0500
In-Reply-To: <1393840220-31086-2-git-send-email-Shengzhou.Liu@freescale.com>
References: <1393840220-31086-1-git-send-email-Shengzhou.Liu@freescale.com>
 <1393840220-31086-2-git-send-email-Shengzhou.Liu@freescale.com>
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

On Mon, 2014-03-03 at 17:50 +0800, Shengzhou Liu wrote:
> +	dcsr: dcsr@f00000000 {
> +		ranges = <0x00000000 0xf 0x00000000 0x01072000>;
> +	};

This is a very odd size -- where did it come from?

-Scott
