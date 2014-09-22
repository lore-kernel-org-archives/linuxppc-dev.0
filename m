Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BD0801A00C5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Sep 2014 16:56:17 +1000 (EST)
Message-ID: <1411368977.16867.11.camel@concordia>
Subject: Re: [PATCH 0/2] powerpc: pci-ioda: Neatening
From: Michael Ellerman <mpe@ellerman.id.au>
To: Joe Perches <joe@perches.com>
Date: Mon, 22 Sep 2014 16:56:17 +1000
In-Reply-To: <cover.1411320262.git.joe@perches.com>
References: <cover.1411320262.git.joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 shangw@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2014-09-21 at 10:55 -0700, Joe Perches wrote:
> printk calls should return void
> 
> Joe Perches (2):
>   powerpc: pci-ioda: Remove unnecessary return value from printk
>   powerpc: pci-ioda: Use a single function to emit logging messages

Patches look good to me.

Ben/Gavin, what do these macros give us over pr/dev_debug() ?

cheers
