Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y3YHp0cWMzDr8P
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Sep 2017 00:05:58 +1000 (AEST)
In-Reply-To: <1506413721-25306-1-git-send-email-clombard@linux.vnet.ibm.com>
To: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 vaibhav@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [V3] cxl: Fix memory page not handled
Message-Id: <3y3YHn6csyz9t4g@ozlabs.org>
Date: Sat, 30 Sep 2017 00:05:57 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-09-26 at 08:15:21 UTC, Christophe Lombard wrote:
> The in-kernel 'library' API can be called by drivers to help
> interaction with an IBM XSL on a POWER9 system.
> 
> The cxllib_handle_fault() API is used to handle memory fault. All memory
> pages of the specified buffer have to be handled but under certain
> conditions,the last page may not be touched, and the address the
> adapter is trying to access is never sent to the kernel for resolution.
> 
> This patch reworks start address of the loop with an address aligned on
> the page size. In this context, the last page is not missed.
> 
> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
> Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/4fc0870d7e462fe3b86e0f938ae75c

cheers
