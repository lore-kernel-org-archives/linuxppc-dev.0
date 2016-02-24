Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2B04A1A04B8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 01:34:23 +1100 (AEDT)
In-Reply-To: <1455757974-4315-1-git-send-email-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc/powernv: don't create OPAL msglog sysfs entry if memcons
 init fails
Message-Id: <20160224143422.9B19D140BA3@ozlabs.org>
Date: Thu, 25 Feb 2016 01:34:22 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-18-02 at 01:12:54 UTC, Andrew Donnellan wrote:
> When initialising OPAL interfaces, there is a possibility that
> opal_msglog_init() may fail to initialise the msglog/memory console.
> 
> Fix opal_msglog_sysfs_init() so it doesn't try to create sysfs entry for
> the msglog if this occurs.
> 
> Suggested-by: Joel Stanley <joel@jms.id.au>
> Fixes: 9b4fffa14906 ("powerpc/powernv: new function to access OPAL msglog")
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/88409d0c863b3ba7d9e3090fb4

cheers
