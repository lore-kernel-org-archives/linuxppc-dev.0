Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B7AF71A0073
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 20:18:44 +1000 (AEST)
In-Reply-To: <1437418902-23324-1-git-send-email-tim.gardner@canonical.com>
To: Tim Gardner <tim.gardner@canonical.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Tim Gardner <tim.gardner@canonical.com>
Subject: Re: [4.2-rc3] macintosh/ans-lcd.c: Missing include causes compile
 failure
Message-Id: <20150723101844.9D3F0140D19@ozlabs.org>
Date: Thu, 23 Jul 2015 20:18:44 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-20-07 at 19:01:42 UTC, Tim Gardner wrote:
> From: Tim Gardner <tim.gardner@canonical.com>
> 
> drivers/macintosh/ans-lcd.c:201:1: warning: data definition has no type or storage class
>  module_init(anslcd_init);
>  ^
> drivers/macintosh/ans-lcd.c:201:1: error: type defaults to 'int' in declaration of 'module_init' [-Werror=implicit-int]
> 
> gcc version 4.9.3 (Ubuntu 4.9.3-1ubuntu1)

Thanks Tim but Luis beat you to it:

  http://patchwork.ozlabs.org/patch/497138/


I'll send the fix to Linus in the next day or two.

cheers
