Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tPxBd4jJ4zDvsB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 11:04:09 +1100 (AEDT)
In-Reply-To: <20161122101327.14281-1-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com, imunsie@au1.ibm.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: cxl: fix coccinelle warnings
Message-Id: <3tPxBc54s5z9t2n@ozlabs.org>
Date: Fri, 25 Nov 2016 11:04:08 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-11-22 at 10:13:27 UTC, Andrew Donnellan wrote:
> Fix the following coccinelle warnings:
> 
>     drivers/misc/cxl/debugfs.c:46:0-23: WARNING: fops_io_x64 should be
>         defined with DEFINE_DEBUGFS_ATTRIBUTE
>     drivers/misc/cxl/guest.c:890:5-26: WARNING: Comparison to bool
>     drivers/misc/cxl/irq.c:107:3-23: WARNING: Assignment of bool to 0/1
>     drivers/misc/cxl/native.c:57:2-3: Unneeded semicolon
>     drivers/misc/cxl/native.c:170:2-3: Unneeded semicolon
> 
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Reviewed-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/3382a6220ff3bac886d9d90766f3fe

cheers
