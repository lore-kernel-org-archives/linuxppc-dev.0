Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vDdTn5JsXzDqBP
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2017 22:45:17 +1100 (AEDT)
In-Reply-To: <20170111170058.10550.91156.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/pseries: Report DLPAR capabilities
Message-Id: <3vDdTn3spRz9s7S@ozlabs.org>
Date: Thu,  2 Feb 2017 22:45:17 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-01-11 at 17:00:58 UTC, Nathan Fontenot wrote:
> As we add the ability to do DLPAR of additional devices through
> the sysfs interface we need to know which devices are supported.
> This adds the reporting of supported devices with a comma separated
> list reported in the existing /sys/kernel/dlpar.
> 
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/673bc4354d42731018494bb69d63b6

cheers
