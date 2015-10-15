Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44F131A06A1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 22:10:56 +1100 (AEDT)
In-Reply-To: <1444709384-10360-1-git-send-email-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, imunsie@au1.ibm.com, Daniel Axtens <dja@axtens.net>
Subject: Re: cxl: Free virtual PHB when removing
Message-Id: <20151015111056.07A5E14030B@ozlabs.org>
Date: Thu, 15 Oct 2015 22:10:55 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-13-10 at 04:09:44 UTC, Andrew Donnellan wrote:
> When adding a vPHB in cxl_pci_vphb_add(), we allocate a pci_controller
> struct using pcibios_alloc_controller(). However, we don't free it in
> cxl_pci_vphb_remove(), causing a leak.
> 
> Call pcibios_free_controller() in cxl_pci_vphb_remove() to free the vPHB
> data structure correctly.
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/2e1a2556ebbbe7b53a05b721

cheers
