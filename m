Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYNvF3TR2zDrp3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 22:16:25 +1000 (AEST)
In-Reply-To: <48ba9b706b8.834928d@auth.smtp.1and1.co.uk>
To: Darren Stevens <darren@stevens-zone.net>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: olof@lixom.net, Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: [RFC,1/3] powerpc/pasemi: Add Nemo motherboard config option.
Message-Id: <3sYNvF29msz9svs@ozlabs.org>
Date: Tue, 13 Sep 2016 22:16:25 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-31-08 at 12:24:34 UTC, Darren Stevens wrote:
> Add config option for the Nemo motherboard used in the Amigaone X1000.
>     This is a custom PASemi board with an AMD SB600 southbridge, and needs
>     some patches to it device tree. This option will be used to build these
>     into the kernel
> 
>     Signed-off-by: Darren Stevens <darren@stevens-zone.net>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/88c13e2f4f0487a67f9eed044b

cheers
