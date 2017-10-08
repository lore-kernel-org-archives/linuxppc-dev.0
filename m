Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y8xjd1lcTzDqG2
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Oct 2017 19:43:33 +1100 (AEDT)
In-Reply-To: <1504878731-28636-1-git-send-email-clombard@linux.vnet.ibm.com>
To: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 vaibhav@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [V3] cxl: Add support for POWER9 DD2
Message-Id: <3y8xjc4G8kz9t4V@ozlabs.org>
Date: Sun,  8 Oct 2017 19:43:32 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-09-08 at 13:52:11 UTC, Christophe Lombard wrote:
> The PSL initialization sequence has been updated to DD2.
> This patch adapts to the changes, retaining compatibility with DD1.
> The patch includes some changes to DD1 fix-ups as well.
> 
> Tests performed on some of the old/new hardware.
> 
> The function is_page_fault(), for POWER9, lists the Translation Checkout
> Responses where the page fault will be handled by copro_handle_mm_fault().
> This list is too restrictive and not necessary.
> 
> This patches removes this restriction and all page faults, whatever the
> reason, will be handled. In this case, the interruption is always
> acknowledged.
> 
> The following features will be added soon:
> - phb reset when switching to capi mode.
> - cxllib update to support new functions.
> 
> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/5632874311dbf432c698fcbe0cf7a4

cheers
