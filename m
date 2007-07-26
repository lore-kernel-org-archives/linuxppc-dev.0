Return-Path: <bzolnier@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by ozlabs.org (Postfix) with ESMTP id 26B1BDDF10
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 05:59:45 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k40so611259ugc
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 12:59:44 -0700 (PDT)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH 1/2] [IDE] Platform IDE driver (was: MMIO IDE driver)
Date: Thu, 26 Jul 2007 21:28:00 +0200
References: <20070725165318.5331.23795.stgit@localhost.localdomain>
In-Reply-To: <20070725165318.5331.23795.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200707262128.00777.bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

On Wednesday 25 July 2007, Vitaly Bordug wrote:
> 
> This is now very similar to pata_platform.c, they both use
> same platform data structure and same resources.
> 
> To achieve that, byte_lanes_swapping platform data variable
> and platform specified iops removed from that driver. It's fine,
> since those were never used anyway.
> 
> pata_platform and ide_platform are carrying same driver names,
> to easily switch between these drivers, without need to touch
> platform code.

Looks really good, thanks for working on this.

> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>

applied but it would be also nice to fix minor issues found by Sergei
(please just send a new version of the patch and I will replace this
version with the newer one in my tree)

patch #2/2 also looks fine and when issues raised by Sergei gets
addressed it will be merged

Thanks,
Bart
