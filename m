Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzNHt43lLzDqJL
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2017 23:06:02 +1000 (AEST)
In-Reply-To: <20170329232801.20544-1-matthew.brown.dev@gmail.com>
To: Matt Brown <matthew.brown.dev@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v8] powerpc/powernv: add 'firmware/exports' attributes to sysfs
Message-Id: <3vzNHt3P8gz9s9Y@ozlabs.org>
Date: Thu,  6 Apr 2017 23:06:02 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-03-29 at 23:28:01 UTC, Matt Brown wrote:
> The HDAT data area is consumed by skiboot and turned into a device-tree. In
> some cases we would like to look directly at the HDAT. This is not possible
> through /dev/mem as it is reserved memory which is stopped by the /dev/mem
> filter. There are also other memory areas which are reserved but could be
> useful to view for debugging purposes.
> 
> This patch adds sysfs nodes to allow specified memory areas to be viewed.
> sysfs nodes are created for each property in the device-tree under
> /ibm,opal/firmware/exports/, and adds them to /sys/firmware/opal/exports/
> with root read-only permissions.
> 
> Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/11fe909d236263f62808dc3c73caf7

cheers
