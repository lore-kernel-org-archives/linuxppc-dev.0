Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vvgsb5JGVzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Mar 2017 23:33:55 +1100 (AEDT)
In-Reply-To: <20170322212201.26036-1-anton@ozlabs.org>
To: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [1/3] powerpc/configs: Re-enable ISO9660_FS as a built-in in 64
 bit configs
Message-Id: <3vvgsb2Mysz9s78@ozlabs.org>
Date: Fri, 31 Mar 2017 23:33:55 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-03-22 at 21:21:59 UTC, Anton Blanchard wrote:
> From: Anton Blanchard <anton@samba.org>
> 
> It turns out cloud-config uses ISO9660 filesystems to inject
> configuration data into cloud images. The cloud-config failures when
> ISO9660_FS is not enabled are cryptic, and building it in makes
> mainline testing easier, so re-enable it.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/4ce410d65a4703aa3fc29c8a1f172e

cheers
