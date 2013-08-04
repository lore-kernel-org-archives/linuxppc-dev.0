Return-Path: <groeck7@gmail.com>
Received: from mail-pd0-x230.google.com (mail-pd0-x230.google.com
 [IPv6:2607:f8b0:400e:c02::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A7D2A2C0084
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Aug 2013 01:49:46 +1000 (EST)
Received: by mail-pd0-f176.google.com with SMTP id q10so2317307pdj.7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Aug 2013 08:49:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 4 Aug 2013 08:49:43 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Meelis Roos <mroos@linux.ee>
Subject: Re: 3.11-rc3+git: __divdi3 undefined on powerpc (from radeon)
Message-ID: <20130804154943.GA13807@roeck-us.net>
References: <alpine.SOC.1.00.1308031534390.1352@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.SOC.1.00.1308031534390.1352@math.ut.ee>
Cc: linuxppc-dev@lists.ozlabs.org,
 Linux Kernel list <linux-kernel@vger.kernel.org>,
 dri-devel@lists.freedesktop.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Aug 03, 2013 at 03:44:26PM +0300, Meelis Roos wrote:
> While trying to compile v3.11-rc3-288-gabe0308 on powerpc 32-bit, 
> it failed with the following linking error:
> 
> ERROR: "__divdi3" [drivers/gpu/drm/radeon/radeon.ko] undefined!
> 
> Some new 64-bit division in radeon that is not implemented on 32-bit 
> powerpc?
> 
> This is new - 3.11-rc3 worked fine.
> 
Not only powerpc - i386 builds fail with the same error.

Guenter
