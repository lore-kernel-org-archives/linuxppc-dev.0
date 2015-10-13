Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3B27B1A026D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 14:47:15 +1100 (AEDT)
In-Reply-To: <1442990508-10199-1-git-send-email-dja@axtens.net>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 imunsie@au.ibm.com, andrew.donnellan@au1.ibm.com,
 Manoj Kumar <kumarmn@us.ibm.com>, Daniel Axtens <dja@axtens.net>
Subject: Re: powerpc/powernv: Panic on unhandled Machine Check
Message-Id: <20151013034715.17F341402D6@ozlabs.org>
Date: Tue, 13 Oct 2015 14:47:15 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-23-09 at 06:41:48 UTC, Daniel Axtens wrote:
> All unrecovered machine check errors on PowerNV should cause an
> immediate panic. There are 2 reasons that this is the right policy:
> it's not safe to continue, and we're already trying to reboot.
...
> Explicitly panic() on unrecovered MCEs on PowerNV.
> Update the comments appropriately.
> 
> This fixes some hangs following EEH events on cxlflash setups.
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Reviewed-by: Ian Munsie <imunsie@au1.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/f2dd80ecca5f06b46134f2bd

cheers
