Return-Path: <vinod.koul@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40TZGx09vYzDr3t
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Apr 2018 02:07:01 +1000 (AEST)
Date: Sun, 22 Apr 2018 21:41:11 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/6] tree-wide: simplify getting .drvdata
Message-ID: <20180422161111.GY6014@localhost>
References: <20180422091415.7587-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180422091415.7587-1-wsa+renesas@sang-engineering.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Apr 22, 2018 at 11:14:08AM +0200, Wolfram Sang wrote:
> I got tired of fixing this in Renesas drivers manually, so I took the big
> hammer. Remove this cumbersome code pattern which got copy-pasted too much
> already:
> 
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct ep93xx_keypad *keypad = platform_get_drvdata(pdev);
> +	struct ep93xx_keypad *keypad = dev_get_drvdata(dev);
> 
> I send this out as one patch per directory per subsystem. I think they should
> be applied individually. If you prefer a broken out series per subsystem, I can
> provide this as well. Just mail me.

Applied all, thanks

-- 
~Vinod
