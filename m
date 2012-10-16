Return-Path: <R1AAHA@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 18A972C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2012 05:09:19 +1100 (EST)
Date: Tue, 16 Oct 2012 13:06:47 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Devendra Naga <devendra.aaru@gmail.com>
Subject: Re: [PATCH 1/9] powerpc: 83xx: use module_i2c_driver macro
Message-ID: <20121016130647.344ba70ac578a05177979825@freescale.com>
In-Reply-To: <1350155142-1629-1-git-send-email-devendra.aaru@gmail.com>
References: <1350155142-1629-1-git-send-email-devendra.aaru@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 13 Oct 2012 15:05:42 -0400
Devendra Naga <devendra.aaru@gmail.com> wrote:

> replace the module init and exit calls containing the
> i2c_add_driver and i2c_del_driver with the module_i2c_driver
> macro as it does the same things as the code that is removed
> 
> Signed-off-by: Devendra Naga <devendra.aaru@gmail.com>
> ---
> 
>  Not compile tested,

Tested-by: Kim Phillips <kim.phillips@freescale.com>

> because i dont have a ppc cross toolchain

fyi, ppc and more cross compilers are available here:

http://kernel.org/pub/tools/crosstool/

Kim
