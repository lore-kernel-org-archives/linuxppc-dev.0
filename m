Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0119.outbound.protection.outlook.com [207.46.100.119])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1ED921A044C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 10:31:03 +1000 (AEST)
Date: Thu, 28 May 2015 19:30:48 -0500
From: Scott Wood <scottwood@freescale.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
CC: <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [4/4,v3] powerpc/fsl-booke: Add T1023 RDB board support
Message-ID: <20150529003048.GA4804@home.buserror.net>
References: <1428566865-35732-4-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1428566865-35732-4-git-send-email-Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 09, 2015 at 04:07:45PM +0800, Shengzhou Liu wrote:
> +		i2c@118000 {
> +			eeprom@50 {
> +				compatible = "stm,m24256";
> +				reg = <0x50>;
> +			};

Vendor prefix is "st", not "stm" -- see
Documentation/devicetree/bindings/vendor-prefixes.txt

I'll fix when applying.

-Scott
