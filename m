Return-Path: <alexandre.belloni@free-electrons.com>
Received: from mail.free-electrons.com (down.free-electrons.com
 [37.187.137.238])
 by lists.ozlabs.org (Postfix) with ESMTP id 90F761A0060
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 15:41:10 +1100 (AEDT)
Date: Thu, 10 Mar 2016 05:34:12 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Kyle McMartin <kyle@mcmartin.ca>,
 rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] parisc: rtc: provide rtc_class_ops directly
Message-ID: <20160310043412.GC9868@piout.net>
References: <1456851608-3374907-1-git-send-email-arnd@arndb.de>
 <1456851608-3374907-5-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456851608-3374907-5-git-send-email-arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/03/2016 at 18:00:00 +0100, Arnd Bergmann wrote :
> -	pdev = platform_device_register_simple("rtc-generic", -1, NULL, 0);
> +	pdev = platform_device_register_data(NULL, "rtc-generic", -1,
> +					     &rtc_generic_ops,
> +					     sizeof(rtc_generic_ops));
> +
> +

spurious blank line

>  	return PTR_ERR_OR_ZERO(pdev);
>  }
>  device_initcall(rtc_init);
> -- 
> 2.7.0
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
