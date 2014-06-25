Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0144.outbound.protection.outlook.com [207.46.163.144])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CD9B11A0008
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 09:35:03 +1000 (EST)
Date: Wed, 25 Jun 2014 18:34:50 -0500
From: Scott Wood <scottwood@freescale.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Subject: Re: [3/3,v4] powerpc/t2080rdb: Add T2080RDB board support
Message-ID: <20140625233450.GA13860@home.buserror.net>
References: <1402481406-10830-3-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1402481406-10830-3-git-send-email-Shengzhou.Liu@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 11, 2014 at 06:10:06PM +0800, Shengzhou Liu wrote:
> +				i2c@0 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <0x0>;
> +
> +					sfp@50 {
> +						compatible = "optics,sfp";
> +						reg = <0x50>;
> +					};
> +				};

What is "sfp"?  Please use generic node names when possible.

I'm not able to easily find what chip this is referring to by googling
"optics sfp".  I suspect this compatible is too vague -- what is the
actual part number?  Could you provide a URL to a description of the
chip?

If "optics" is the correct vendor name, it needs to go into
vendor-prefixes.txt.

-Scott
