Return-Path: <groeck7@gmail.com>
Received: from mail-pd0-f181.google.com (mail-pd0-f181.google.com
 [209.85.192.181])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C543E140083
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 May 2014 03:44:28 +1000 (EST)
Received: by mail-pd0-f181.google.com with SMTP id w10so3919945pde.26
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 May 2014 10:44:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 9 May 2014 10:44:16 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Yuantian.Tang@freescale.com
Subject: Re: [PATCH 1/1] booke/watchdog: refine and clean up the codes
Message-ID: <20140509174415.GA5009@roeck-us.net>
References: <1399514666-2572-1-git-send-email-Yuantian.Tang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1399514666-2572-1-git-send-email-Yuantian.Tang@freescale.com>
Cc: scottwood@freescale.com, wim@iguana.be, linuxppc-dev@lists.ozlabs.org,
 linux-watchdog@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 08, 2014 at 10:04:26AM +0800, Yuantian.Tang@freescale.com wrote:
> From: Tang Yuantian <yuantian.tang@freescale.com>
> 
> Basically, this patch does the following:
> 1. Move the codes of parsing boot parameters from setup-common.c
>    to driver. In this way, code reader can know directly that
>    there are boot parameters that can change the timeout.
> 2. Make boot parameter 'booke_wdt_period' effective.
>    currently, when driver is loaded, default timeout is always
>    being used in stead of booke_wdt_period.
> 3. Wrap up the watchdog timeout in device struct and clean up
>    unnecessary codes.
> 
> Signed-off-by: Tang Yuantian <yuantian.tang@freescale.com>
> Acked-by: Scott Wood <scottwood@freescale.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
